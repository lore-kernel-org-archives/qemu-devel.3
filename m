Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91C1C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx21U-0006ep-8a; Thu, 20 Aug 2026 08:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx21S-0006eF-N3
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:37:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx21Q-0006qX-VI
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787229448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+WStP1QPLmVzlQ8i2Qdr7Yf3fFby8VT92dvCi0ZT/3w=;
 b=QZtfDNOkLuZbeTaXNVWSr+vnJUVq7DBBryZV4Ws7ARdbHj7oGMhNn/m9so+YBkbGFtFJij
 FDI+XCtw1D9cb1YZ+XmpQ6Q23UGIUamyJ6C62SC3eDdPFmVZXTRk3gv3JXAyPorZYNROAL
 4KNNDicKORCjhzHqtJLN3H7OWgJRcvE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-OMM0DcpQOSC9G3xidEPIcA-1; Thu,
 20 Aug 2026 08:37:23 -0400
X-MC-Unique: OMM0DcpQOSC9G3xidEPIcA-1
X-Mimecast-MFC-AGG-ID: OMM0DcpQOSC9G3xidEPIcA_1787229440
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58F3E1956088; Thu, 20 Aug 2026 12:37:20 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AEF41800346; Thu, 20 Aug 2026 12:37:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 05/13] target/s390x: Constify S390CPU for cpu_has_*()
 getters
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-arm@nongnu.org, Cornelia Huck <cohuck@redhat.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
In-Reply-To: <20260820104730.25462-6-philmd@oss.qualcomm.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-6-philmd@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 16:36:07 +0400
Message-Id: <178722936786.2678991.1892992747168805177.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=309;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1EiQr3LzEusuJSAgP95yzAyjF+hDC+nt3EzYEG8d2dk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhvS7ynKog4rftkf4/FRz3XiKyo6kxaZSo9HAH
 m7cS3mXbg6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaob0uwAKCRDa6OEJdZac
 5fFfD/46Ra0VLmOHSFMILiaXVEQQTGdhy4tlkjSbyk2S2RVBV5WAavH+NUBa9q1oC5Wa8YHqJi3
 xeB3zuObthdTw7lTt2+QgUcMO8WucUOSckWBBd3C15F3iEBNONg3nvdcOkVNpbrd4KEPr13fHmC
 cnWfCIwRLJMrd5C1jgPx94Qo2dpIpPpCdXybwfp2G5/XdNFHJrkhV/M6BWzLexZppAs2ptI7SI1
 Pz50wDY75CBgr6Ky5ami+a2wNis5k+JfgluqEeUsxpIKzYUB6uvc+wecSW/ZU5szRMt06n7DgQ0
 Xr4CgAdmi8daSjrNRxjQwyhoZF7ImDixbxQyGmi9aJTwADDIpkccTwahiQBPRdWbKDEJ5l9atRM
 iy6yid3BoZMVSOE0HrusGwA1JWlmNs868iMjqKZyO5myFhoirOy7TtPT7gwhUDduA3PYWiaq2an
 q1mQnvNWmFMXTp8IwbkkfUmTk692locCWAKqQYrSe0Cxcjv6mBiJk8jrJZFKRK4xklob9+9hNuQ
 +/4G0EQVhPKql/AeHYkhvBELoxOVBAZexyi+fpDgUj5lMKGDlDgaN5P4k4Y0a9ZbAcjjDoGsc4m
 UdsvoUT6pXa3JYZWUI/qG0QKgZWi2lmCvUqV10L337Ye8yHz/RLzlIpt2EtLf0Hw1pbGuyRljl5
 2B1F1ppBaO9bmjQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 20 Aug 2026 12:47:21 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> Add the const qualifier to S390CPU when the argument
> is accessed without modification.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



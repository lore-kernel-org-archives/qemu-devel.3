Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807BACA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCEpC-00008q-9q; Thu, 01 Oct 2026 07:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEpB-00008X-7e
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEp9-0006Ov-Qs
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790853579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMfUnEijOpQcT9qvbvZDsXxDPBidl7oRQevK8poyrQo=;
 b=jQDudXn6j4XIM3CAGrTc16SZKwr/4LO9zXB+Y23P5yONhV3artQKVad5URWbbgeDB9peNL
 wRL9aYbCpo7aANxZg7c0k+9/XeMVPl6ekbo3vFEJdzTTQEROIApR9kAtKVEfUM4GzIOUm6
 ZNrz69ll0yrmLCLFyPr3Bdd7SKf50js=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-0Z_f_IVRMj-AXiGfrOJ0Pw-1; Thu,
 01 Oct 2026 07:19:34 -0400
X-MC-Unique: 0Z_f_IVRMj-AXiGfrOJ0Pw-1
X-Mimecast-MFC-AGG-ID: 0Z_f_IVRMj-AXiGfrOJ0Pw_1790853572
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31BDB18005B3; Thu,  1 Oct 2026 11:19:32 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF30D418; Thu,  1 Oct 2026 11:19:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 09/13] tests/functional: update x86_64 tuxrun images
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Song Gao <gaosong@loongson.cn>, Ani Sinha <anisinha@redhat.com>, 
 Warner Losh <imp@bsdimp.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Anders Roxell <anders.roxell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260930164649.433573-10-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
 <20260930164649.433573-10-alex.bennee@linaro.org>
Date: Thu, 01 Oct 2026 15:18:52 +0400
Message-Id: <179085353201.2170790.1849228492778911632.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=362;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rZ1omox/FWF7aJwmjf1CmIIrePOvD6uNeO2fLj/UPAU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvkGe1ysLqUn/cCDpyATob+f2jxhCYpv+8M5DR
 NSa+Z0s8aiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5BngAKCRDa6OEJdZac
 5fsJD/4n8FSzT8EfOvEIFlbfREgaYH3s1eyiYFM/dAmqoRhOBzBTfB5/mR2c4VRs+zTfW4q5sjR
 ia8ZNjNKP3DpwAsC2ru6XDcROYaazkje94578E8Y96ALuGHhfeUeLwfNNQX1WYie1lwkANNKpg5
 1mHf6Lmjm3nXxxylRfeXjyzlmr2k6IxBzU4bPaaOZXOV5ck0xSlqAbiKJurkjgLwL3tKSkMDD5i
 MU1uiPwX/QvbuApOhAxKMRj0qW3rqOmgfVzcEXk+z1Gl2vDkGh0nENSWtyH4ejvM8uE9hK0cVB8
 2BiKap14vs2FG9awuSSkJf37IjKlVmJouifYGww8KmJsQutt52338Egm7C6ftLue7tqU0DYBplU
 YFDFu3LocbUJovZpq5Onq3PjKd/r1PjBIoRjVd+ujHXG2G8WCLMECapY1cPWwA22E5UAZGJ87T3
 QXGrOtZ67uSbJleN/RGqrdqqcwr2MOJ8SmNTNDWld2Ov09XhbG5vwy0psLKkz78N+Mjowtm07w2
 9+rdO6EcDZpqT6sH5DEqCjUDLcHZ4MXEOiVnMijXGMRnqksnVRH/WIYaPObuv5ULglQKLPPvQvq
 RrudQCP0a5e4mWXDjcZaWua6YBGDO6Y4BfPr/f0pr7+tj7G3XXR8JJggjLrbpxZnueZEy42iDJv
 y7+u3R1rheQHsBQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 30 Sep 2026 17:46:45 +0100, Alex Bennée <alex.bennee@linaro.org> wrote:
> We now split the fetching of the buildroot image from the kernel
> itself. This is because we will want to access additional metadata in
> future tests.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



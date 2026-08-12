Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471CCC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9bK-00016y-PF; Wed, 12 Aug 2026 10:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9bJ-00013D-Do
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9bI-0003Be-1u
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786543595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YjDOD6N/lpGaWaceLfU7Gj043LzCYon/n6tma44hGcc=;
 b=DzbKFuCABMV3tpBDiz7YYF3PEFLBzknWXuK0aKelpROqM6sDOjh/voQIv05LrGTkqSOnWW
 oZyckiKLWhc/ZgVvxKW4Q1EMiWNlF5xiLFGhuo0zZRF6oD6fbdwOo7ALQ8jzRkj0lyc2tZ
 k01gNopke0BebGZwSpFAuXzIaJBadLM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-cAobiFU7Nwec_RMZJAe3kw-1; Wed,
 12 Aug 2026 10:06:32 -0400
X-MC-Unique: cAobiFU7Nwec_RMZJAe3kw-1
X-Mimecast-MFC-AGG-ID: cAobiFU7Nwec_RMZJAe3kw_1786543590
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FF8718004BB; Wed, 12 Aug 2026 14:06:30 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A2D50423; Wed, 12 Aug 2026 14:06:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 12/16] system: Remove unnecessary
 'monitor/monitor.h' header
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260812131147.83188-13-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
 <20260812131147.83188-13-philmd@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 18:05:43 +0400
Message-Id: <178654354342.2071945.881619156363946412.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=307;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=R1cf3oP/ff+LeYZgzkBaPgS5X9yDh7gM9FNYqVKDJWM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfH266WANOwqCYoibElBeRS5hZlrlXCtCSL8DS
 cOS7md6Yb+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanx9ugAKCRDa6OEJdZac
 5byRD/9tRKxYH+5fgsCVUSe6P3IvIkjsV5TB0pqI3rL1PdUdHRkJQZLQeU6MWERSz4mG+H+W/Mq
 Bok+SOaJrGgNdVtRRrHvJr7KZvbvK5Pvw4GDe6HFlQYe5iVOfRwA/i1f4G2UsCCVrixZKx5CMyU
 +WBfZ1OKY2IXVa69s9oWD90/nmQIS2NNFb0KD5F6KuBUDG2wV5I2CuhHrHaABdJaKew+v6RRvbV
 GKFs74nMNLgwfZtKvLk9jIfzVOzO7DLz9rieFt4qFvFokuygBVP0INIYanX3V7XIDDqaxvDFNp8
 BB/T4FTnd4TON3eKjpq0vBsyHERtc5DurgYIg/YqBaFpZaLvhhCO9djVjGSx/8ciRn4qmn86Iff
 IqWdG+yFf8fiQRqJBOqgmWLb5/aftjn+gcxhTTTzinZgJR7I/0BWTUyECvqc6U5s8zWDilv3dds
 LJpbmmD0fATqYYRAaEKhW6kU3PYGWI1/8XEDsHCM4W7QwY1j206XxX7uk/DNkZsOWGDGgyTKUb8
 pndLWNEY9uFi3M+mmhNtwGV1ahjyay2ClZQtNLf7e13NzjFaTFTZtuhASGrwkNhe+szIu5qMMxX
 cwBvlrNRmIr5nYQ21t0KNvLI5SItTnAocrYJA5J40cvPTF7lCbQgUrQpjVbzlzdsa55B+ahq1zn
 VRU7qhNFSLv03SA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 12 Aug 2026 15:11:43 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> No code in device_tree.c or physmem.c require declarations
> from "monitor/monitor.h".

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



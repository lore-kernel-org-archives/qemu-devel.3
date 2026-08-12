Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364ADC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9bF-0000rV-8u; Wed, 12 Aug 2026 10:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9bD-0000lv-3o
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9bB-0003AU-Rl
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786543589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7UJFTMDT0dwlO+Cx7AhM0XHfVnWGskEOHwCCmseARQ=;
 b=SspEk8BGN+J9htZGkiqW9WpcIojYtW3sKbr9IiXYI9EdDppZYEm/6lQpk8iiMmbfJyQnW8
 aw+gWB3U2CjlihX9iIjBtI5aIPtrBR1qky2z0OB9Cxq2VsrvMp6Lh2p7KY8A7u+iWjCCOn
 Xr8fV0Hsq62FuJDjyQnQTpi+biU8gWc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-49liWQhkPWyyF7EMsl6yIw-1; Wed,
 12 Aug 2026 10:06:25 -0400
X-MC-Unique: 49liWQhkPWyyF7EMsl6yIw-1
X-Mimecast-MFC-AGG-ID: 49liWQhkPWyyF7EMsl6yIw_1786543583
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 199A1195606D; Wed, 12 Aug 2026 14:06:23 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B26973002D26; Wed, 12 Aug 2026 14:06:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 09/16] monitor: Reduce inclusion of
 'qapi/qapi-emit-events.h' header
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20260812131147.83188-10-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
 <20260812131147.83188-10-philmd@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 18:05:43 +0400
Message-Id: <178654354341.2071945.11710071294833886466.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=705;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NtFTN9l5LhXontrm2zMXiOJ0YO+q9iFt1JsGeXSvEKA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfH26C/l3a9NHBDQdSz5/K7+TD/mTbz4D9T7wh
 5fvjyty3aOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanx9ugAKCRDa6OEJdZac
 5dALEACyq+2ux4a6HZgAvPDniCZLzD7jmSvhm9bcwwdRyE9PzzrbaRpIX2RTpEU7JuSgeEF3asM
 ztKng2Cj+2+LMkJRfc/noAnKfKlxj3/OWMVTum6+MoJHkWDcAKDJ7gTVW0KijDn198+5eG8mJ0O
 c+zzB/lrxEXAcazeChvjL1oyhcEgbK4YyMRb1C6dum1v0ZGZmj2rmxCdjX/sQ/9clVAyAoNGc9C
 dgAO+UvrxJDkVYIsWEU9MOyQdWIqqktC/fn+q8TJn6ZzvE6TUpzeu8iwgZNlqwB6v1+jhjjVE8G
 uDvrKK06kWnzGktu2i/lIBg2qeuCKRN0ffwtz8Dlxu5Polf6CdVZU1VA8Qbr6ifdzIMVTNetdfj
 eep3MjhIUedxkWxfEl5/KXHOxKa7epGmTkcUr/QNqNkbraR1WSQIpDBXbJZlTejnDY6So01/pg7
 hFhNJZhF8AX3PgnmVgWzS9Zq/+PSJU6Q8caHjGHsV7koZEaJIC+XE+KqZ5tHj2ZH7eW0+PSlYgC
 ayoNi62G1Sxfp1I80yCAfYgGbf4+Quxhb6MrWDca0NsQ1MHLQatOpIwIV4Qit0KjQDvccDPQ8jB
 XO7n7Eos0r5HAXoOIPv2qt0nkJTBZDH8q/oLVqIYPr1UiwY0RZdbRW12E/OVeyzVMPAWygwK+yt
 owxeKCoNdSm4uyA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Wed, 12 Aug 2026 15:11:40 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> "monitor/monitor.h" don't use anything declared in the generated
> "qapi/qapi-emit-events.h" header.
> However the "monitor/monitor-internal.h" do:
> 
>   107 struct MonitorClass {
>   ...
>   116     /*
>   117      * If non-NULL, the monitor is able to send event
>   118      * notifications back to the client
>   119      */
>   120     void (*emit_event)(Monitor *mon, QAPIEvent event, QDict *qdict);
>                                            ^^^^^^^^^
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



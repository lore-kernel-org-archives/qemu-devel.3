Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC4DCA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 14:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl7tr-0004BO-ET; Mon, 02 Sep 2024 10:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl7tp-0004At-RH
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 10:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl7tn-0004QK-UA
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 10:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725286759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+BjZDBlSGBfpBJ9uBUNEwLaU3nhdvRdIhNsi7FrIKcY=;
 b=BOBB9NRXz4jCCxr2wvhHeWxuOprDL7qBKk/cHkQDkRUrxOn5A/BpUtQMjpFeD5EJEMCbDy
 dVzCVz9Ji9pXcn8s4A1dyJvbtNVsQ8nFQYHtu8gkY+/feib9P1zffMWT1do2bJpQlZqpXu
 l22YolKSNoQo0RRbWUb5hVkGMlXUyVA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-9Q2Om6O6Ni-rj1AOz_YGpA-1; Mon, 02 Sep 2024 10:19:15 -0400
X-MC-Unique: 9Q2Om6O6Ni-rj1AOz_YGpA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42c80412dc1so13415175e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 07:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725286754; x=1725891554;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BjZDBlSGBfpBJ9uBUNEwLaU3nhdvRdIhNsi7FrIKcY=;
 b=kwsEXmQYMhMFkdb28Ia/yntF7kbXItMIZeUijoameSsTZ04FaN3/OtzXkcTAJuPHSB
 DZVYylsgjSYGsVXU86hL8APi0tqYyTq9MBkCwLLbxu+svickd3iXNOg/MXnUH6ultkBm
 GeTU6rz8tsqk/QOGmvHLQYBw1DlNKfHlRRmSL7cvRW/Q9nr3l2yhdXcmCHpdXHAq33a4
 kC4wJqrpiE05JcplCzyTZBATyjRupJfGtDTEin6btl3gGRv5thyvllC2g0CEoSHTami4
 Y78ri8PpYyEqKx5Z5T/TePdgyw+AmKpjiBu99goYcssUrwPwd8VoadZhs6Ne43kzckOQ
 wYAQ==
X-Gm-Message-State: AOJu0YwjLZQpwoYse+WWb0JrL6yHrcsyGEGwt3Ai1DmGdRA1Vl/CWBKm
 gz1LIZ77qzO7EJWsQrTlFR6bSzNHvFcDFMrevOqr0DJynoMjoJfEUfLeVm68SjG54DGIHFLuk5L
 yNRTZPU7mCeQU9VQE/M4pWlFc/H3G1TZc5omoporvHBoyoAdLOZ/A
X-Received: by 2002:a05:600c:1f16:b0:426:5ddf:fd22 with SMTP id
 5b1f17b1804b1-42bd8355641mr51778465e9.6.1725286754430; 
 Mon, 02 Sep 2024 07:19:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCVJi82Me6XHrSKNtjeFoSSzxiNW/ttN6Wwv314O4+h2ch79dTwISlRcbme+be6khWvAz1PA==
X-Received: by 2002:a05:600c:1f16:b0:426:5ddf:fd22 with SMTP id
 5b1f17b1804b1-42bd8355641mr51778015e9.6.1725286753549; 
 Mon, 02 Sep 2024 07:19:13 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.206.174])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ef812cbsm11625908f8f.83.2024.09.02.07.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 07:19:12 -0700 (PDT)
Date: Mon, 2 Sep 2024 16:19:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v5 07/16] target/i386: Allow setting of R_LDTR and R_TR
 with cpu_x86_load_seg_cache()
Message-ID: <wjsce4c3itxtew3ydomnnv6gwewv3l3xp3oxxt25sc5rb5cm64@xkbaf2sblyr6>
References: <cover.1723560001.git.roy.hopkins@suse.com>
 <ce09939f65b9f6e0f52464368364999d2a9e7735.1723560001.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ce09939f65b9f6e0f52464368364999d2a9e7735.1723560001.git.roy.hopkins@suse.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Aug 13, 2024 at 04:01:09PM GMT, Roy Hopkins wrote:
>The x86 segment registers are identified by the X86Seg enumeration which
>includes LDTR and TR as well as the normal segment registers. The
>function 'cpu_x86_load_seg_cache()' uses the enum to determine which
>segment to set. However, specifying R_LDTR or R_TR results in an
>out-of-bounds access of the segment array.
>
>Possibly by coincidence, the function does correctly set LDTR or TR in
>this case as the structures for these registers immediately follow the
>array which is accessed out of bounds.
>
>This patch adds correct handling for R_LDTR and R_TR in the function.
>
>Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
>Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>---
> target/i386/cpu.h | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>index c6cc035df3..227bf2600a 100644
>--- a/target/i386/cpu.h
>+++ b/target/i386/cpu.h
>@@ -2256,7 +2256,14 @@ static inline void cpu_x86_load_seg_cache(CPUX86State *env,
>     SegmentCache *sc;
>     unsigned int new_hflags;
>
>-    sc = &env->segs[seg_reg];
>+    if (seg_reg == R_LDTR) {
>+        sc = &env->ldt;
>+    } else if (seg_reg == R_TR) {
>+        sc = &env->tr;
>+    } else {
>+        sc = &env->segs[seg_reg];
>+    }
>+
>     sc->selector = selector;
>     sc->base = base;
>     sc->limit = limit;
>-- 
>2.43.0
>



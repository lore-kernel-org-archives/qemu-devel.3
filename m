Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB28BC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAaj-00077e-6w; Tue, 12 Mar 2024 18:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAaf-0006Yi-OK
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAae-0004Nh-4p
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tOh3XMBYaTXqwwXatODmJZBdFVP40l8SCuosqwHz9Dw=;
 b=ii1iK+WkwFh73+BkYZVSb+Pdsrx0lio9MABqJgCrfXbiQs8EmxralwvrNcIlrAgJfyKVzz
 Nj01Q8Hc0EKmKjuQm4kN6PW2JP3yqXZ73ZoZk2f1tBMggqft3a7SXgK3/EmauWLKN2mGVj
 h+ZePIaWy7cmeOxf7yUuyDSxPUihxLI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-ILpux4BcPtGBPqoRS-_61Q-1; Tue, 12 Mar 2024 18:27:18 -0400
X-MC-Unique: ILpux4BcPtGBPqoRS-_61Q-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-56864b8f5f9so1354730a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282436; x=1710887236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOh3XMBYaTXqwwXatODmJZBdFVP40l8SCuosqwHz9Dw=;
 b=TNBB36HZdgGwX3wE7Gnl5m4YT2SqAoLN3038QZNd0hNkegA20Iy4EuHz7KkAq8jCPe
 ox+/i9jhjOTZ7nGRHpft602IKNWFte4Cnvk0pzLsQS6PGryDmO2M7s9xRCFO1d+MSMfL
 4FkVqRTkC6IcShBV1dv1SA5PoXgtQlr1PdO65zdP/Tx/q+JCZ6MqPeZAksTbyNkY/Wcc
 gSbCFZxn85P3vRkFBmwbq0HwCkiAzcGVgcq2KOx2APV0c3gAT1BOvxYIDFjvCeBW4i9y
 d7o7vcBsUyFiWGzDgmh4GdqaixdRnPiSns0BipkuH+We44J/p7kKh8H2diVx/dPDD2ml
 P5ow==
X-Gm-Message-State: AOJu0YwCWJ+lJfxyFXGyd5Xzu98hPmSKybUXh1X6VBRsngtQTsNX2EOn
 nyBWUOb3P6KhtqIdrB6jIF8tlZw8KyjioojQsA+V/HjTH1Y6xsxVPJ3rnprMObliy/7+1eMceoD
 iaz03VFh7i9U8PvbqPofC6EvGryodK406GmMK8VNqh6z/5bs8Gjqi8TSCfz5mbXy0zOKNU0fTST
 pNvMwUYBGwY5Id1AX/djxMx3oI1pEHfpWg
X-Received: by 2002:a50:c315:0:b0:566:1127:4bb5 with SMTP id
 a21-20020a50c315000000b0056611274bb5mr8334967edb.1.1710282436390; 
 Tue, 12 Mar 2024 15:27:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm4qsXUUXmwGcv9qOYj47DS6cCLXV96uTaaYGD6Tno7zfR92dtE36eMtWzlJW8oTvz41fALg==
X-Received: by 2002:a50:c315:0:b0:566:1127:4bb5 with SMTP id
 a21-20020a50c315000000b0056611274bb5mr8334950edb.1.1710282435946; 
 Tue, 12 Mar 2024 15:27:15 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 fe5-20020a056402390500b005684173e413sm2318047edb.72.2024.03.12.15.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:27:15 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:27:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 33/68] hw/cxl/cxl-host: Fix missing ERRP_GUARD() in
 cxl_fixed_memory_window_config()
Message-ID: <2a0e0a35002db7ac64f4e82ea2a4ad2fb6d934b0.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

As the comment in qapi/error, dereferencing @errp requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
* - It must not be dereferenced, because it may be null.
...
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.
*
* Using it when it's not needed is safe, but please avoid cluttering
* the source with useless code.

But in cxl_fixed_memory_window_config(), @errp is dereferenced in 2
places without ERRP_GUARD():

fw->enc_int_ways = cxl_interleave_ways_enc(fw->num_targets, errp);
if (*errp) {
    return;
}

and

fw->enc_int_gran =
    cxl_interleave_granularity_enc(object->interleave_granularity,
                                   errp);
if (*errp) {
    return;
}

For the above 2 places, we check "*errp", because neither function
returns a suitable error code. And since machine_set_cfmw() - the caller
of cxl_fixed_memory_window_config() - doesn't get the NULL @errp
parameter as the "set" method of object property,
cxl_fixed_memory_window_config() hasn't triggered the bug that
dereferencing the NULL @errp.

To follow the requirement of @errp, add missing ERRP_GUARD() in
cxl_fixed_memory_window_config().

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20240223085653.1255438-2-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 2aa776c79c..c5f5fcfd64 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -26,6 +26,7 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
                                            CXLFixedMemoryWindowOptions *object,
                                            Error **errp)
 {
+    ERRP_GUARD();
     g_autofree CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
     strList *target;
     int i;
-- 
MST



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E7A606A331
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BMZOMxT1;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FjAkwtO4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8iT-0001nS-3e; Thu, 19 Nov 2026 15:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xU8iR-0001nH-FJ
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:26:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xU8iP-0007DD-PN
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795120000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zzLahnCh7vHXMkhpE4qQVEViCHrPIKPUXcE/kX8uJHw=;
 b=BMZOMxT1C0Pl0lW/g47+ECINIMuJihg2znlCBONr8oIpjOEF27grvh0oJ92B/RJdf5KD01
 n823/zRsqIUGQcIFby+xjv78wI7vvQ9La478NqDNYhubnIKwCKZBaSkahFzr9mPKeX3Jwl
 Gx3rB32SfRrjgvtl6i6GCFqA9nk46Fw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-Q3YE1U68N723eImbfIl1Mw-1; Thu, 19 Nov 2026 15:26:38 -0500
X-MC-Unique: Q3YE1U68N723eImbfIl1Mw-1
X-Mimecast-MFC-AGG-ID: Q3YE1U68N723eImbfIl1Mw_1795119998
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91b937ecbb4so4077046d6.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795119998; x=1795724798; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zzLahnCh7vHXMkhpE4qQVEViCHrPIKPUXcE/kX8uJHw=;
 b=FjAkwtO4dTP7APwd0+a1+JDtQ+bBbCMSA9sNt7+QDbt5KT1ZBVw2ZmIF2sBfyDN9cp
 C/kJthUrZ6K61QxyGsl3hrbJlHQXrbkWQLwum7ZmQp/y/yBpet3JwYirZYF1LqLs69tU
 GpYEBLhPHvowLqZ8Uf1uX7NjUiqtf3IC9dUgXck1Uuzl6DCgfizpr6TpmiZtHqloMXiJ
 n2Yel/rJ+rhYtNkEBvJpA9hhIXYxnQ1FpY4KKmIHltSWPiGFkeCEi3UINLcMEBuQCdQ/
 hHYnvtLjpamis/llV3H/wfja8dSYtcI/2uZqBMt7kLmdbm3Zcpbnp3Ts0HcGPbXyQbjB
 /Mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795119998; x=1795724798;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zzLahnCh7vHXMkhpE4qQVEViCHrPIKPUXcE/kX8uJHw=;
 b=PEjq3iAF/3FFztw/iQnr0qmvTBD4GAQQrueGqvgbBtlZpPktbwAds1Jq9n5S83iZq3
 9lpVbKgySb2K1XrcXn693uCE7n73ejFI1aU9Ypevd3vi8/gku1MH0U/CNyIkaxapYmVY
 OgQuJhV4J7ovaMo+y/pEYgKCLih999iu4MZ9Sr25UgRJvDWTSpqbMjs2mu0wL1o8fMRU
 /9VbaAH+nBm8XSnJYdyPJtztd7LIBy8Yv0XAiBbKscTPm80a64Bn02GvzJTK9muK782Y
 NrbW6n5dgf3RJRHfsJFT2uKsCw2WyVA1D/ny5lo+S7b5BDaxl+5OmBkB5wDh1cjNbqNc
 DmNQ==
X-Gm-Message-State: APuU4Z8YC/OGbdCRF4qbwwd1QpXmKq8GxMaPh4hSW7X19moCRP0Gwwio
 QRQyCBTG6m8Zrg5ER2Iuqw1nQk9Dnr4H6kfVC1BsTqRyLhS5wWxyVuAFA1yUBFAwhJ55AHArpm2
 4m4cFZDia3rlLpm2wpsTvmWHcYBfzflL+ZjNhzantoDOw2LJj6rmA2Brl
X-Gm-Gg: AZFdTZdQpOAjMWTRH3VNps2ssS7BmYnJ52Ve4d5GyGjkf8pC06LnLusZ6RDHx9UszmG
 UldpVAd7EUp7GRSNXYMMfEVGDZgg5aFc0x26HKhB8oSVxLMadoakFqmGMFDtgc3WuOqft+irFGz
 ONOYmwvDLGP42JmsZq9RzzyYlQ7Pz8/MaNdBMfYVpiu5Ie8uYTc/FeRbZsg4yk51urt4yzx1fMq
 EL8FwCrJRFPLNrPbbHy1yXuG0EpGYSV0BtCEc5Ri3A44zBPxLdFtfKhMVr2Ybrpx3W52ilNv6cL
 CvXHn2cGyEbP44sbmm0UVSi3ApaQg7FoLe+Q96hUNVkPngT73+w/Y/SbvFjUgrbWWl5v9NASkw7
 k7ozOUVGif7z7jlwTNqM/iCMc+gxknrfQA4JQ7SMTX6yg
X-Received: by 2002:a05:6214:6181:20b0:91f:316d:2f5d with SMTP id
 6a1803df08f44-92134ab7ee2mr11910156d6.17.1795119997882; 
 Thu, 19 Nov 2026 12:26:37 -0800 (PST)
X-Received: by 2002:a05:6214:6181:20b0:91f:316d:2f5d with SMTP id
 6a1803df08f44-92134ab7ee2mr11909706d6.17.1795119997064; 
 Thu, 19 Nov 2026 12:26:37 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921349b253csm7519266d6.15.2026.11.19.12.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 12:26:36 -0800 (PST)
Date: Thu, 19 Nov 2026 15:26:35 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Fabiano Rosas <farosas@suse.de>
Subject: Re: VMSTATE_VALIDATE failures on outbound migration
Message-ID: <av9be5IWLpQJu-F_@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <CAFEAcA-iAdTGc0M4ZV5LYXscVVj2oEr7FN+Ac=oBo2_oxuygzg@mail.gmail.com>
 <av8k8oiG8lRh5bVI@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA_8EAke9-dk-2HfkQ5BJyuODtcSK+DUcmYKRSKgEf=Wnw@mail.gmail.com>
 <av9D4pVMM989xNcE@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA8UWw+CpaS8wyy0A_MSeXhJ3NzJGcLm-iHkzmw5t9Cd_w@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8UWw+CpaS8wyy0A_MSeXhJ3NzJGcLm-iHkzmw5t9Cd_w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 06:53:19PM +0000, Peter Maydell wrote:
> I don't think you can deal with the pcie_aer usage this way though,
> can you ?

Attached a patch for that, please have a look.

IMHO it's a matter of if we think VMSTATE_VALIDATE() useful.  At least for
the current form, I don't like it, especially hijacking the field_exists().
I hope post_load_errp() is enough.

Thanks,

===8<===
From d92c2548ea084091d3baf51682b150dd4e0f2316 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 19 Nov 2026 14:53:47 -0500
Subject: [PATCH] pcie/aer: Remove the usage of VMSTATE_VALIDATE()

Paving way removing it.  We can replace it with a post_load_errp() instead.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/pci/pcie_aer.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 43b14c1f22..87248556d4 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -807,21 +807,51 @@ static const VMStateDescription vmstate_pcie_aer_err = {
     }
 };
 
-static bool pcie_aer_state_log_num_valid(void *opaque, int version_id)
-{
-    PCIEAERLog *s = opaque;
+typedef struct {
+    uint16_t v;
+} tmp_u16;
 
+static bool pcie_aer_state_log_num_valid(PCIEAERLog *s)
+{
     return s->log_num <= s->log_max;
 }
 
+static bool pcie_aer_state_log_num_post_load(void *opaque, int version,
+                                             Error **errp)
+{
+    PCIEAERLog *s = container_of(opaque, PCIEAERLog, log_num);
+
+    if (!pcie_aer_state_log_num_valid(s)) {
+        error_setg(errp, "PCIe AER log num too big: log_num > log_max");
+        return false;
+    }
+
+    return true;
+}
+
+static const VMStateDescription vmstate_pcie_aer_log_num = {
+    .name = "PCIE_AER_ERROR_LOG/NUM",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load_errp = pcie_aer_state_log_num_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(v, tmp_u16),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_pcie_aer_log = {
     .name = "PCIE_AER_ERROR_LOG",
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT16(log_num, PCIEAERLog),
+        /*
+         * Only to use STRUCT for a post_load_errp().  New code should try
+         * to use something look better, e.g. subsections in order.
+         */
+        VMSTATE_STRUCT(log_num, PCIEAERLog, 1,
+                       vmstate_pcie_aer_log_num, uint16_t),
         VMSTATE_UINT16_EQUAL(log_max, PCIEAERLog),
-        VMSTATE_VALIDATE("log_num <= log_max", pcie_aer_state_log_num_valid),
         VMSTATE_STRUCT_VARRAY_POINTER_UINT16(log, PCIEAERLog, log_num,
                               vmstate_pcie_aer_err, PCIEAERErr),
         VMSTATE_END_OF_LIST()
-- 
2.56.0



-- 
Peter Xu



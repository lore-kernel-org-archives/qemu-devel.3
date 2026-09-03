Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD22C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x27Vj-0006KR-LW; Thu, 03 Sep 2026 09:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x27Vh-0006Ii-VI
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 09:29:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x27Vg-0003IQ-F8
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 09:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788442182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ESVT2yLRXtfbaK4REXN7flcj25MixY+4PT66/UtEXI=;
 b=U1zU3sLE83eL7hKrY/atFFK74+lzoKBvVHhgyUsLZUXund13thiInA88Dk0vrXA/U81PAc
 m98WLJZcW7bchdZcJiUDrkd9672pFkidjQjhtMsn++LRc5JpQltImhXDUzaVYZG1TnTGz5
 xm2NuiLcZl/vKURXfyG+/uhntaT9m1M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-WGFlnAMkOoGu_7duskDPKQ-1; Thu, 03 Sep 2026 09:29:41 -0400
X-MC-Unique: WGFlnAMkOoGu_7duskDPKQ-1
X-Mimecast-MFC-AGG-ID: WGFlnAMkOoGu_7duskDPKQ_1788442180
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49545071724so16470755e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 06:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788442180; x=1789046980; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6ESVT2yLRXtfbaK4REXN7flcj25MixY+4PT66/UtEXI=;
 b=XFcChNSdn+rkXS5QN0MW5V28yG/A+HBIps/8OVnEqccd73C0fnIPn8zGeaK7Ho9DyB
 XEDHYydZ/Jdzo5oCwuMj70QQt2Q8kUq/c9iGAp1IqMdxsHZ2uLEenRhCpAm4u09l8LJa
 qsTykJD7j8MlVZnzELLQsjldLlkkagZDNZKI2nrfv3SXg2w0h6s0f3USjpEKVjz83J2s
 pyQ8zpJLjH7imtQGijNabCSsFOaT1KOm7J+9ttET1RJl6KZHUPwZtKbiJBYxO/1O4VUS
 2wT29GiLg76pOq4lWdYk/XMaTDlMuUL1PcxdJm3yS6WHF3sQLZecSncfy2nutzar0r8O
 dlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788442180; x=1789046980;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6ESVT2yLRXtfbaK4REXN7flcj25MixY+4PT66/UtEXI=;
 b=i7jAyZ1JpLdTc7NDX+nReGHDIc1lFqTxahz9ck96HCN3qW2O+kyvoe9USau+MgsTtA
 I8jJLYb8vCeIvXOOiSpTqoJPvIKn5V8SIMhxftLefbcSTmMRZfH53OfRQdPQFH680twQ
 Awop40K/+0vlakN4hwxlNIFMQa0v59otrTCJB0L6hWII5Mq4JV6GlCNE8PuWXAPFU/C9
 8zdnmmk3a3DzmXW4MOvLmIjiHLPe/uP2qPracRuZ/OG+J5ero4DXNzKvHoSfDVURlWQl
 C3r32degO0pWo7OJX4zg7UMx1EgeQ6g9bcsyrmOX1h2mKHEM7GafSqOeGCrjgG8hEON0
 7yow==
X-Gm-Message-State: AFuF++lzOQGes9Y7OctBCC+mb5+CHgWJy6ibmW+yE3sOGsFzqta1Cnna
 MCKPfZNRGDFAQpm8QDJMRAlew411F18EHUBGLnhcGaeSh/GKg/FQ8kux7jmjd7uD0frc/XUQkPa
 fu6zfEPuyi95TFhWlpUCzVK9bVN2XHJMiuPqnM39XHAGpUnNlVM2sNHzg
X-Gm-Gg: AYBFou3Em5BZvb5rf+8cM96Ln6lCADf2m5N7DdIPquVnxBvN28B8ikLGwFAuKBhhi2K
 43y9uzD0Yba2eUUqJy+44FFdI9BC1JO3y0+RGtX6sSTzq3dsczdMXiRVPPMtP6MAgI2Aj0sGqPi
 3ahLvbAOTYmFEuGf0pKb5r6ZieMnLlvRhUs47cAdvS0/unrRddhzIALSmqgxoRIKKUEg+1BGdYj
 8ynLWOAtlhPPs8U2HmFNT+To3W3lblUg38I5lKLR2LQqhEuCRXuH/07ZJCHXkcNNLCUlYy1Nq+D
 6GHVoOhig6FY2L2KaPMjZuhHZDIDdbN7r+fZpkBgz73RC7jJWcXnl4/Gb7UrXjPCunq7oq+OfFD
 o4tYgUNE9V/lrRG7biFz8
X-Received: by 2002:a05:600c:63c6:b0:49c:eb16:9fd with SMTP id
 5b1f17b1804b1-49ceb160bb1mr127551775e9.3.1788442179750; 
 Thu, 03 Sep 2026 06:29:39 -0700 (PDT)
X-Received: by 2002:a05:600c:63c6:b0:49c:eb16:9fd with SMTP id
 5b1f17b1804b1-49ceb160bb1mr127550925e9.3.1788442179324; 
 Thu, 03 Sep 2026 06:29:39 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5f912esm72286385e9.4.2026.09.03.06.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:29:38 -0700 (PDT)
Date: Thu, 3 Sep 2026 15:29:35 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH 2/4] igvm: move set_id_block call into the SNP ID block
 directive handler
Message-ID: <aplyuTrLtvtrT0Kb@leonardi-redhat>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-2-e93a6cf8c5ac@redhat.com>
 <aplM8ZVCrsjuELHT@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aplM8ZVCrsjuELHT@sgarzare-redhat>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Sep 03, 2026 at 02:57:44PM +0200, Stefano Garzarella wrote:
>On Tue, Sep 01, 2026 at 12:09:19PM +0200, Luigi Leonardi wrote:
>>set_id_block only makes sense when the IGVM file contains an
>>IGVM_VHT_SNP_ID_BLOCK directive. Move the call from the removed
>>qigvm_handle_policy into qigvm_directive_snp_id_block, where the ID
>>block and ID auth are populated. This avoids a no-op call to
>>set_id_block when no ID block is present.
>>
>>The ID block embeds the guest policy, so the policy must be known by the
>>time the directive is handled. Process the initialization section (which
>>carries the GUEST_POLICY header) before the directive section, and
>>copy ctx->sev_policy into the ID block in the directive handler.
>>
>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>---
>>backends/igvm.c | 81 +++++++++++++++++++++++++++------------------------------
>>1 file changed, 38 insertions(+), 43 deletions(-)
>>
>>diff --git a/backends/igvm.c b/backends/igvm.c
>>index 85de0d54ec..6545382546 100644
>>--- a/backends/igvm.c
>>+++ b/backends/igvm.c
>>@@ -778,6 +778,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
>>    ctx->id_block->version = IGVM_SEV_ID_BLOCK_VERSION;
>>    memcpy(ctx->id_block->ld, igvm_id->ld, sizeof(ctx->id_block->ld));
>>
>>+    ctx->id_block->policy = ctx->sev_policy;
>
>Is it fine to copy the sev_policy in the id_block in any case?
>
>I mean, what happen if IGVM_VHT_GUEST_POLICY is not in the IGVM file, 
>so IIUC sev_policy is 0, but the user set the policy by the CLI?
>
>Maybe this was pre-existing and handled in the next patches.

This is a very good question: id block per snp spec *requires* a policy
to be set. So can we consider an IGVM file that contains a id block directive
but not guest policy to be valid? If so, I need to modify the code and read
the policy from `kvm_start_conf` with a new callback.

Luigi



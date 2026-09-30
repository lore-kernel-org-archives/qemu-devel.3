Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1119ACA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 21:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC1nS-0001qD-9l; Wed, 30 Sep 2026 17:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xC1nK-0001pZ-5S
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 17:24:54 -0400
Received: from mail-pz2-x2a.google.com ([2607:f8b0:4864:3b::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xC1nI-0000te-I3
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 17:24:53 -0400
Received: by mail-pz2-x2a.google.com with SMTP id
 41be03b00d2f7-cc7c058617aso1352592a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 14:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790803490; x=1791408290; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=H7kxKVmQyn0odAFFtPbM4RSi32dD79a5EtnalGn7XCs=;
 b=HiK5qeOFyHQBbwCgquPhyU7VZq7UQ2XqPamz52gHfXmUI0e3QLmLf+JWcPX5W6GFWq
 PRHj+nXyFSGBYKS/cqe893SwEvSwJWcRvhQrHMlWGqNIdt+vWUEdTDO9uSYB1IK0YJx0
 AGEY1DJLSyE/Km52b0DLDQUtkUn1Q1hkUA8/sROQcpXfMIuUEIlOJoFWqSqab3PYfxMb
 ZAmU2YEDeXYcZOg2RffRojDq1/Pu6t/X9qqfPzzjZDjilb8VkqbtA4hRW0obMuvWVlOI
 dFH9NHkgJYmfxucGKJVcE1OjDxlg4oHAsaqKXYpyd9oSxqIdnBCf3AcxavMmVIRmki2H
 J8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790803490; x=1791408290;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=H7kxKVmQyn0odAFFtPbM4RSi32dD79a5EtnalGn7XCs=;
 b=XrYg+KAlzhOU90A6H0Tvupt8BLPictVanbZ60278p2TOAo+mLKi4dn5OEjIEyda+Dr
 Y4/H5J1M14Gh4SQJNr8IJfTucVy3WVDEBYHpWOogl6bC/bLI3yrdOPkvpMvkfNOZieFs
 aMdykeU82X8WFMBXTBCX3c2LdDg2h5VcwY9LGVwnevDBMIIM0dU4Dh64kzSGh5Kqr2Fd
 8ngH4AuvvXpj7Y4xDUKDDaWukPMy7e3e9by9EfvHW7uoleP+sK2enu2M7DTsBehrDK9A
 VOLeBNxaXRnSx0jRObwxKKYEfgQ+FPu8iEugD9rEk34PFR07cIWrI6z4V54UY+u+R8SO
 NY6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQn+bj0yNYt8phua/qMSydGwGFrYifVqm4uc4RkQD0tUt7MdQECn0Yw0htttkJYlFtmo8BOHi76kT4@nongnu.org
X-Gm-Message-State: AFuF++nlojgP0EpxDGWhCqW4on3AnccPki9KOgRyhQPFcb3JQnMn9LtK
 0rFoAsF8qbMjblm2rorzjQBPYfA+pi+Ns/lE6ZC0hH5gNB2EDYA/RJ8Fx2s5baLkMgM=
X-Gm-Gg: AYBFou1b+XHNqGZk4kRhRzGDA12t++zfgnz1oTW0oh/yk9T3nf4Hab5RGJlZvS0OFQt
 Cg2bpQBQH1c02S1m42MoHMe7oes8UkCK3tHDzyOqYPXayyVaQLnAPr8MW1M7CkkrtZw2HHNuo4F
 gQrI3su2mvPv+hcMr6bvSSL8vuFUDdKzxN07Es5w9zaYEc3Ft4ZcdoCL4eECQX7OrLpYqwPlDoM
 uP41CCeSwfK6bkSQCDjewxx/7uJpBLTgD3ci1djXaO4JgZdn2kaNTLF5RpFWZC2ySEWA4kpZKgC
 s0zID6MgHQzJdiga3HBq02A/TQlj9daJgNK0t5QhXCFXmRDCXAstEMrCCdVs1aENjEPmlfbgiTk
 PvmncDt0cj5r0QjaDWyNvU51/w4y1+WaPli1Xu0iISCSraGK/GivgbUXlkhfrg4swJYU52M/xKw
 7HKVyb9RZDVjHtHLpv6mmJ89sK/u5OSQ1cVMIVZe2LEfedTvzrIJj4mp/BJIFQQkO8FAK6H6+4
X-Received: by 2002:a05:6a21:4e01:b0:3d1:39e9:b261 with SMTP id
 adf61e73a8af0-3de9dcfd17fmr2343533637.0.1790803490226; 
 Wed, 30 Sep 2026 14:24:50 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:f5b4:4d0e:70d:9fba])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc7e54c0be3sm423609a12.30.2026.09.30.14.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 14:24:49 -0700 (PDT)
Date: Wed, 30 Sep 2026 15:24:44 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Michael Roth <michael.roth@amd.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, enju.kohei@fujitsu.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 02/24] target/arm/kvm: Return immediately on error in
 kvm_arch_init()
Message-ID: <ar1-HJ-5QzSvcJUS@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-3-mathieu.poirier@linaro.org>
 <rocrppdlgvg6jcolhnlt7z7ilqmthepim66ujg4e5diayw2gmg@s345fbhx3sov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rocrppdlgvg6jcolhnlt7z7ilqmthepim66ujg4e5diayw2gmg@s345fbhx3sov>
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2a;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pz2-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Sep 15, 2026 at 04:01:06PM -0500, Michael Roth wrote:
> On Thu, Sep 03, 2026 at 01:35:49PM -0600, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > Returning an error to kvm_init() is fatal anyway, no need to continue
> > the initialization.
> > 
> > Leave the `ret` variable in the function scope because it will be reused
> > when adding RME support.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  target/arm/kvm.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index d40a6a985914..ed99be7fd80c 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -596,7 +596,7 @@ int kvm_arch_get_default_type(MachineState *ms)
> >  
> >  int kvm_arch_init(MachineState *ms, KVMState *s)
> >  {
> > -    int ret = 0;
> > +    int ret;
> >      /* For ARM interrupt delivery is always asynchronous,
> >       * whether we are using an in-kernel VGIC or not.
> >       */
> > @@ -618,7 +618,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >          !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
> >          error_report("Using more than 256 vcpus requires a host kernel "
> >                       "with KVM_CAP_ARM_IRQ_LINE_LAYOUT_2");
> > -        ret = -EINVAL;
> > +        return -EINVAL;
> >      }
> >  
> >      if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
> 
> There's a error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap")
> under here as well that doesn't have a return -EINVAL after this patch.
> Is that intentional?

This patch did not touch the clause that checks KVM_CAP_ARM_NISV_TO_USER.  As
far as I can tell, it is mainline code.


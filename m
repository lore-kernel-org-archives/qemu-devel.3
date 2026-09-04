Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C70C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Wja-0000Av-Ha; Fri, 04 Sep 2026 12:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2WjY-000082-AY
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:25:44 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2WjW-00036z-LG
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:25:44 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8534d507f59so1333977b3a.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 09:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788539141; x=1789143941; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EoggvHQ/cuPoPSyx5k+9q6Wpui3ScOQ6Pt0lTizqruc=;
 b=hxFiJwRHBG08SQoRFU/2O6hTD1I0iggrUyRFi9tOHhIUSyobMNHxk9QWqkVDzANbJC
 G18KlR1TPRGvjn6CEZjoDurvgqb/aEApCOiU11AtUsz5I+RVy6rtZd4iGNLhqJRcQ035
 DXIPPIF01GQuI0z65rL19lmAYMsjB9mAvvSZQX3/0T6RN//AvZGQAM7EDp2eEdIs1vvY
 kQoQ6DeYpMErFIW4epJN/jINztiaEyCHrugF5w1vg8Yy6GoyOhlpusmqCuxeCtBhlC0S
 rsl8G3v/lmcCfViocuGaJD/DF8VgjUE3vnH6uf4Sv9dDetrEwie2vCLOOvUwQdWuPXEF
 yAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788539141; x=1789143941;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EoggvHQ/cuPoPSyx5k+9q6Wpui3ScOQ6Pt0lTizqruc=;
 b=gyWli2igN42syISwvoijlVvsVuOxS6ZfWuRCVBWwQE2QMTpsXA4dDIga5WNNqxaLVj
 jRsQJfsUSg1oI7Sw5JN4dx4Op6aquw6/UwnA8wAAf6DM5Jk3jGPcgN0j+bDFn78OtLHe
 BXSszcXwBeTYbCYW54PZ7o/Z24YqafBrp4bPnqz2oLcG0xQ/5RXFRzXrQj7FhXotMWtr
 DRigUuZhnSsPLzrYQ0Sfqny629W4MeqrMMLRqYTN0Fq430EFyD6WrT+mFJXPtGBG0N18
 +BhV8Zvaz3P5YwopENJSnRt8RxZPc8endLyyaPRNcUkMKvGW86ka1ET/iQig8ldcCMBK
 Qw0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgMsEAJmo6Nq52oOBP/crBMYI5QTYf6EqEWGNScu/E0hA8zN++3JKB8zxp0Ry4o+djn8nReSKICwOw@nongnu.org
X-Gm-Message-State: AFuF++mvG2kcUtg87pXXZMexN/pM5taJU7eVxPxpvLwbuHae0VlpEJlG
 3Vf/5HdFPB0KZhITZaWCKWrU1ld8GNF+fGHsBpN7EPxjwxgcFYNQ6AauiAZ4uWfeBQ0=
X-Gm-Gg: AYBFou2BPH/NMLyetfJd2+q4GYrsyO0uKyTuBGWi6l3a+4GidaHpPgazgytWHeH3wns
 0Jk8XpQ3MvC0ryMfxwOJeYOLyki1b0+22ChSJMtIlrJu3/GLxvpj4K256YVsft8o7VfPrnECKb+
 quuOP02ZzjW2UjQGsNlsSQplVumPnBkmhowjj/JtveCPrzS3EqRGhWY9evRd1ey0EoBjUrlb+yY
 CrIcTVv+zAsx2py3UB4/9lXk8OQg4S6j67Wu8tCkfWQI+Rskt8QgkmLk5o2xDiBEVzQfrIoBO0z
 SWyc83rGibES+ZGM1nRaa7GQnqA/W0f3YbL6s6G6swkMpU19EpV2j1CCxszdUrlK4kcWYiV2bKj
 BVYMHXYT9fBZh7dntm3ESmHAP9oufjkgggv0yhRW1RfAkWAoBVv3EcvRG7vOEDxIvbcwjn4lagT
 VbHI3XJUqzEJqTDrb/1Z4ja7UOThpe6Icnw7bCuGPwmuMJ2qG8+jY3DSf6bTluu1GZ
X-Received: by 2002:a05:6a00:1c97:b0:857:db2:222c with SMTP id
 d2e1a72fcca58-86168b8719bmr9475111b3a.9.1788539141081; 
 Fri, 04 Sep 2026 09:25:41 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:f95f:75de:b3f0:3bf5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86152045f74sm1377683b3a.10.2026.09.04.09.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 09:25:40 -0700 (PDT)
Date: Fri, 4 Sep 2026 10:25:37 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Kohei Enju <enju.kohei@fujitsu.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [RFC v4 07/24] target/arm/kvm: Create scratch Realm VM when
 requested
Message-ID: <aprxAYZzTOS9lPth@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-8-mathieu.poirier@linaro.org>
 <apo185JSe61bK3zm@FCCLS0092175.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apo185JSe61bK3zm@FCCLS0092175.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x434.google.com
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

On Fri, Sep 04, 2026 at 12:09:32PM +0900, Kohei Enju wrote:
> On 09/03 13:35, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > When a Realm is requested, create a scratch Realm VM by setting bit 8
> 
> nit:
> KVM_VM_TYPE_ARM_REALM is no longer defined as 1 << 8, so shouldn't this
> be updated as well?

This changes often - I'll look into it.

> 
> > of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
> > for the guest PA size.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5157FFD88EF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 10:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0dCg-00071U-9R; Thu, 12 Mar 2026 06:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0dCb-0006zS-MG; Thu, 12 Mar 2026 06:23:37 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0dCZ-0006Mq-6B; Thu, 12 Mar 2026 06:23:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773311004; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HzAUyZ+WZu0IOjv5xTRZ9uqHZjijrUfHx8oea8IcxAPFh5G/9fDKqn/Cqsz0I9yQ7nH++t0qDUAsGF+daCB8NUWMQnBDsinLreyh56XhWerafTpZJKwW7MzDk5e7fCE2YSOywUQi8CRrh4b4XlOo27zhfQOBatAScIXgil8Lp2A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773311004;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=sEqK9ywX4OxZj1skOVdtrA5nqG7JTNMSnSY+xg1WcCQ=; 
 b=CHyAXcgDgfkmywCxu2D0sNfDyseGf8icJAIDXghICc/pGaMTQmXBKnUojOoEEAMlmuaWU3tAnRyvGTp2uPzukb2amSwypjyhlAo55OjL4uRM1TRuKVOH67jaT6UWXdOyeI8etEz+wbd7iOi2gexCFbwp3+i3jK4pD5mhSHIMF98=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773311004; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=sEqK9ywX4OxZj1skOVdtrA5nqG7JTNMSnSY+xg1WcCQ=;
 b=imDPKrAbOZT9JoPQWRAJgxeWkKFlwQISRzYeo/+5UV43VC87u1Ij/0CDtSeDllG5
 fa276SAeiRvnZIN7Zz7P9SdPzGQNGFImE3EvATp7EvEgoBAuIGpeRVf6h5EfKxqK+vX
 wbCnJOQMJq0U/8CHwqodJvGG0RIpSJ1uIprRontQ=
Received: by mx.zohomail.com with SMTPS id 1773311000903220.70661856732454;
 Thu, 12 Mar 2026 03:23:20 -0700 (PDT)
Date: Thu, 12 Mar 2026 10:23:15 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 00/14] Add ARM64 support for MSHV accelerator
Message-ID: <20260312-lucky-cocky-whippet-2a5f3d@anirudhrb>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 <877brii9wq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877brii9wq.fsf@draig.linaro.org>
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

On Wed, Mar 11, 2026 at 04:54:45PM +0000, Alex Bennée wrote:
> "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com> writes:
> 
> > This series adds ARM64 guest support to the MSHV (Microsoft Hypervisor)
> > accelerator, enabling QEMU to run aarch64 VMs on Microsoft's hypervisor
> > using the mshv Linux kernel module.
> 
> Does GitLab (or anything we plug into it) support runners on Arm64 with
> HyperV and a Linux Dom0?
> 
> I looks like we would need a dedicated runner to defend the
> functionality on CI.

Right. I think we would need to onboard a custom self-hosted runner for this.
That's what we did on GitHub for the Cloud Hypervisor project.

Thanks,
Anirudh.



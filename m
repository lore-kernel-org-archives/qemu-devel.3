Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADBBC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt5T1-00035s-Tj; Fri, 14 Mar 2025 09:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.67d43086.v1-d376aa8de0974526885927a87c67a5ed@bounce.vates.tech>)
 id 1tt5T0-00035O-7b
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:52:50 -0400
Received: from mail136-29.atl41.mandrillapp.com ([198.2.136.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.67d43086.v1-d376aa8de0974526885927a87c67a5ed@bounce.vates.tech>)
 id 1tt5Sy-0000gG-83
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1741959302; x=1742229302;
 bh=uG1KcJgwcW9T2cGN3oyD/12pz8pEMNAmvmnymfhPGS4=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=g9hfdA/eM7vcBcCDkScEmdyush/aDVF9niLOhO1Tls29AehJMunYoTLPcqPx4URix
 /aMh2g12ndPjgUTy22QDmBO2Q/RAv0cXaFZI+qOcWz1ZgrHfQZCrr1K3y464VLIJyL
 qwG0X7PDYl8MR1m8vayWQ7hjrpV24L5fx3uL30NrDreDdDALoHwoF2h0fysd+K3iam
 uuGcNVID5TPwnEu+AzI8k4h0x2P7SOTZNSkGAuW/rTouVWcrQV+q0j9IK/9Uc1NvBZ
 Z7+4wG6V3IKm+zhLAqIfOwcWPE+QHkNe69r5WmAQgVIJNVrhCRzbohvB2D7UahSoln
 xxQo5w3wwGFsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1741959302; x=1742219802; i=anthony.perard@vates.tech;
 bh=uG1KcJgwcW9T2cGN3oyD/12pz8pEMNAmvmnymfhPGS4=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=JLfWifvyw3oMpzh/DIkhmNZnn3FOeOLirZx5hCQxLEpJmiyfjBrlmwr/pGpcuVoIu
 fByVYbcweMsQZSr7P+jLoVx6FJX4LBZ/iPwhvohnmYlx2QihXR4olRcsJr2TAYMy5/
 hudYvliyweXeQ59PZIeXS3fEzmoqQIVSV6WfgZ8kP/fcI+MggULGuM1sVWsTSFvWHP
 wXDJuAaRWZnF/BAQRml7SWQp9RISG2jZlaNr/J+RKpmHFJEJy5WNTAhhvlfN+4YBHH
 UwqWVJizjxihe4lGii0OSWJTOD6a2L1zM3QHS6AxlxRtem1HD3UbiF+zgVJ/AFupkT
 hzdtfbtU4eblQ==
Received: from pmta11.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
 by mail136-29.atl41.mandrillapp.com (Mailchimp) with ESMTP id
 4ZDljL2BPPz6CQ8XK
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 13:35:02 +0000 (GMT)
From: "Anthony PERARD" <anthony.perard@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH=20v4=2012/17]=20hw/xen:=20add=20stubs=20for=20various=20functions?=
Received: from [37.26.189.201] by mandrillapp.com id
 d376aa8de0974526885927a87c67a5ed; Fri, 14 Mar 2025 13:35:02 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1741959300664
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, "Paul Durrant" <paul@xen.org>,
 "=?utf-8?Q?Philippe=20Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, xen-devel@lists.xenproject.org,
 "Peter Xu" <peterx@redhat.com>, alex.bennee@linaro.org,
 manos.pitsidianakis@linaro.org, "Stefano Stabellini" <sstabellini@kernel.org>,
 "Paolo Bonzini" <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 "Richard Henderson" <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 "David Hildenbrand" <david@redhat.com>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Weiwei Li" <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 "Nicholas Piggin" <npiggin@gmail.com>
Message-Id: <Z9Qwg4PC_1bEaOLK@l14>
References: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
 <20250313163903.1738581-13-pierrick.bouvier@linaro.org>
In-Reply-To: <20250313163903.1738581-13-pierrick.bouvier@linaro.org>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.d376aa8de0974526885927a87c67a5ed?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250314:md
Date: Fri, 14 Mar 2025 13:35:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.136.29;
 envelope-from=bounce-md_30504962.67d43086.v1-d376aa8de0974526885927a87c67a5ed@bounce.vates.tech;
 helo=mail136-29.atl41.mandrillapp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Mar 13, 2025 at 09:38:58AM -0700, Pierrick Bouvier wrote:
> Those functions are used by system/physmem.c, and are called only if
> xen is enabled (which happens only if CONFIG_XEN is not set).

You mean, 's/is not set/is set/'?
> 
> So we can crash in case those are called.
> 
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
> diff --git a/hw/xen/xen_stubs.c b/hw/xen/xen_stubs.c
> new file mode 100644
> index 00000000000..19cee84bbb4
> --- /dev/null
> +++ b/hw/xen/xen_stubs.c
> +
> +void xen_invalidate_map_cache(void)
> +{

Is this stub actually necessary? xen_invalidate_map_cache() doesn't
seems to be used outside of xen's code.

In anycase:
Acked-by: Anthony PERARD <anthony.perard@vates.tech>

Thanks,

-- 

Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


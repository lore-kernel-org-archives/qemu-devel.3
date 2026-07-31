Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9EBC5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wplj7-0001sP-D7; Fri, 31 Jul 2026 07:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wplj6-0001ru-0Z
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 07:48:32 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wplj4-0000EG-Ni
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 07:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=mXeX/7U6FHNloNjEttUFcYrLWhSDB/KmzX3ab3LksLA=; b=PHsW+usY7bdSn+b
 K/Rg2z9lK4O4CxvewCrWPbmpt+BwCa4cf6hpEpnkBeTuHo3FjT9fuJkwh0BFNcCCRTIBpy0F/Qwoj
 jhkeg9wipymtUkiAjegbup62VTvJstHWqKcId9T9fFbV6kEDetqc0vO6/gRoyhv4D8owRhctPPM0Y
 do=;
Date: Fri, 31 Jul 2026 13:46:57 +0200
To: Anton Johansson via qemu development <qemu-devel@nongnu.org>
Cc: Anton Johansson <anjo@rev.ng>, brian.cain@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@mailo.com
Subject: Re: [PATCH v2 40/50] test: helper-to-tcg docker tests
Message-ID: <20260731134657.1d18653c@spawn>
In-Reply-To: <20260730031025.12926-41-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-41-anjo@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=ale@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Alessandro Di Federico <ale@rev.ng>
From:  Alessandro Di Federico via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 30 Jul 2026 05:10:14 +0200
Anton Johansson via qemu development <qemu-devel@nongnu.org> wrote:

> Adds a docker container with LLVM versions 15-21 and a docker test for
> building helper-to-tcg and running end-to-end tests along with running
> check-tcg, for testing targets such as Hexagon.

A report on my tests. Everything passes except:

1. `test_max_temps` from `hvx_misc` fails
2. I get follwoing 7 failures (out of 1689) on the (private)
   test-harness suite:

       v65_Q6_P_vmpybsu_RR
       v65_Q6_Vw_vinsert_VwR-compound
       v65_Q6_Vw_vinsert_VwR
       v65_Q6_Vw_vsub_VwVw_sat-compound
       v65_Q6_Vw_vsub_VwVw_sat
       v65_Q6_Ww_vsub_WwWw_sat-compound

   Also note that `rundriver.sh` exits 0 even when tests fail there.

PSA: Anton is going to be off until Aug 10th.

-- 
Alessandro Di Federico
rev.ng Labs


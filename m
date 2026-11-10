Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896BB606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=tqIG5h+f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQmx7-00008H-J6; Tue, 10 Nov 2026 09:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric_devolder@yahoo.com>)
 id 1xQmx5-00007p-ID
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 09:35:59 -0500
Received: from sonic302-21.consmr.mail.ne1.yahoo.com ([66.163.186.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eric_devolder@yahoo.com>)
 id 1xQmx3-0005WD-O9
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 09:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1794321353; bh=nhJYNw0vuFDCnSjF5MWUCwGoMndS/SBRzIFDsev1bUA=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To:Content-Type;
 b=tqIG5h+fhnBLTmalGgPaNpj0x/bTAuHprAeTddVm4qOqcinlrupSqUwCXTFgxtLY8G1m98VjurRPUNmVL7OwJaSc86uGuEvshGO/jdT426Q8+zPsJY5nTWS/h4nutfI3IK6xj6E6HMn0C2N4nr3G3/vRZ0e5f82e/ji5wRohTf+8kcX2JZaKoIdArpLvJzOV/cgZ7szPiC5Z/CysNTji4mbIsj7A80J/7ATy9JjiPNaUiNWc9vaz1xT54gXKkZLrLU9btntXg+Kc7AR/eJHs9oY9J0BcNXA90xqUk3yViqq/LBQLjBxg/amAjXbXZoZFxi+RozGNsp/YbBAj9i55tw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1794321353; bh=F/tlGyJkHCR/zlNqXrBLpnhxE7vPJm+bRMukvRB3zGg=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=eolS/HKlwg7YOzLayPNHy4xPXBKJ0MzXe9F3JFQQSuNEVJqwrO2l4BUz8ywHxfiJ6xH+GEW3QtenEXB1rFhQxiSWBruJfg2mA2gv3d8p5gN2SdbJoLuAeqElDff07IrhBYjgUXtetJ9RJG1/olEhSQyW3g1EdH1WNVyDjHfZm5LFDMZpdYjfeWVKS3fsAsUzWoUzD7stY6pvSRmII7/bc3kofDa+O8EMN/+7L9BShsjobgSqZ2s8IR8oV/N5gwCc8EzOT/ZnEDV3zHNNUSzPitEzvLJqClPkBn2qOr49POiZL7wXw5SDUjUD0Als3lF0hdV37TFjUzDZCll9d2tbGw==
X-YMail-OSG: xi6CbYcVM1nhz9Jeq0O5DE8v9cBUCDngO.mrCLnmDpUrREfG9NH8BqCZTlfTLXe
 MPNsPCooYYY2pIkua1tp_3yQNHibloVDJwrcNXA8gdsZrjNCJHDD98hUa.Pn2azwJZE2ZMZnKKjj
 OHzDk78P0ajVt4yGFzvHrkW1nwSpl4iQkO3Jg.MmrGpGYNQuOo5YxrI90qYAXJHTU3pymHJx2aCU
 ONe0LTZEE6lzORHZDnJeka_XdGMaVHR76MzPJxWweCiZ0aV0ktGGKMgixVfKOxqM.xw6qf_D8VnN
 3vNtmstdpBgqj9mkZAzltbQ_x_TotvgfrK0gkySFCV7i7kdoZCr0EZ88CQnBs5.t7ZOUZnkCGbp7
 FCysne8gcjaiAnQo6Jf76w_OAU9ZukvqXs6wPc38lvlBIA96dqjYBR8dqA1950yW4kAsP.dMzdfw
 bVGRTyNcBB45J1Yw4AJE4UXtXHjFd3ii923aTjJ1HtjkdY967Tm8CIDtM77MIJZq0oSryA3sV04e
 sZqhOxQzOeQKthcQGLTJeczktIIluRUikcJdI1qsbxo.vWCf.CXXp5QoLwh9TUOmF8qdLMkqDZ_n
 cmcZnKsmkU7ee0Tk3W1icR35LXGtcMOmGq_Rgb0MAbR7rIZmYxqiblnUjaOcDq6UjDidpf8FbEYc
 cs57Y6bF.Ps2q.FgA5vWdAsvqOJsWkkzoximHmVd.iD3WXSFAo76.QOr7amf3qJ8pM9T0ugoYKRF
 EicKDsoZi4bP9WQ2W_sWj1DFFbMKSqYf0YLgPXct4jKQMdPwfDBeFrufCxteuHkfueQ9piSCz23u
 dzBmN7Ca176vkl2Wur6uF.Xq2IkaV567MwbZ_ha9b9HZxkxMvvuGjzTZZuN1Y_LvBsqCoeywYbiN
 dQvK4Q3_IuASP542sF.zHfRjQb5hCmfTfJoGb943l0vPp0eLVdKJsOwAuj6pyJkO4BPdQvUAwgJo
 i9g_SzoGedXXRFho2IYfUeQyMQ1JTEamVYcg3FXWRHAGgmUB9nDUf23j43txkukwVcBhxWiU201x
 l3soUAVqm1bYkQQ9bhBd9Z.j4B30q5zI4bZXWBil7QeG2SzrVLTwGcIznhjRp9kAedwxzLt9og.W
 H_OdaZrElszIDadH_qHNq0CT6.IovSddfWTiXmWCRueU3Ye8f7eLvSwEeoG2p.tviC_VukZsBlgI
 WlM3IM26SjCVm9CB2M12eBIFjgyZflsUFVkPuOP11iE4r97ABOq_mtD6MeVbE_hG0t3WkbXu5Htg
 G2hibogEentsjRkKtMxlvzUYbMKTLynYME5wDn.XZ0EATB4TpWmVD11dTPveO9jGgT.4GBfnyJOI
 ZKTkmpE9cXTIcOCDhgfLoQNEognZ3.CJs72KCCOhai91Oj1Ix9gK0f4Ua9hjJsG1Tnfyr3eIS7gs
 ve9U6NN9C6ywlnlxaazxtSp9lszxB23hC3DSobi8qStOSG4sLF0oIv4v30dCuq4NSnlV1ENmLESE
 xQJXQZ79aniSlh_mU.W2XvMDZgRawRQavEDiGJZF.VRANKh0vJpJpJY6qlKrWz3pqojA36_1feiO
 rIyft1WPLEBDGCRxpBugnkAbVEbgGs64dNectWEox3V4zOJKsoHnocFtyw77KTGtXhKwNWtei9ig
 IPz7LD_jYLMo94MblI20fN9fIcFy.KUuMqD93vOsZ6A2ww3QnhA46dfDi0mFJBTFOAi.zscAAxML
 3F7_QL_deaCCn1ECBNplXOB2Mhz8H60N3NA0E48V_zCqYgkXRP5XvqJTJ0W7bPFq4ZZbukYv4rjT
 5GgRZEvklCtbg07Y6iP0nRJaYeLut9zYOVjLEretUuDv.tJ9cHeC94j6Ms9RHUXLS1B9XtXyg4_Q
 zgdl.udvya6bwLYgAaQUjwAg3Fx6vVo1hmHHb8Sk6.Rgrg6.WSnJSwW7xyWMc5lJiM1R.TCViWhs
 _LdbKFEnojIeXzcRU85SNDbeg_.E0F2oHCqTs4DOgWfJj7RoJAUrWZy9aCQxJBbiQlRqUQCRqTfl
 CzAndsLo3CMhx83pauXABTmBI.uMkgs25OHMrBH33Itc7BCYjzL655Tq.9rV2BE1Lw3VZ1C6D6YB
 7L80AXSkdAvuRDdgHz8Pe34svbGUn1uZOAIS40iBd9yA4bA_P9aMtXPXdglJk0J62XWBqIkD2g7P
 roF6RWWwM3uAgyOX2ir_ZYaE8.OYvCOnQI6d9XsccS2YvP7eXkYNFSFqdDwkVNRan3XLFrl_5XXI
 Pan20zwJrJ3riTrx9D4bUgWY_ar2R6UZFUpcD62HY2bNOwYEmp6cDM3j0uyXCWCf4GioblMWim94
 26lw-
X-Sonic-MF: <eric_devolder@yahoo.com>
X-Sonic-ID: 4368ee6f-5f34-4802-948b-797eebede6f3
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Nov 2026 14:35:53 +0000
Received: by hermes--production-bf1-6d6877594b-bzn75 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 41de68968a083db8f7dce8033493d38b; 
 Tue, 10 Nov 2026 14:35:50 +0000 (UTC)
From: Eric DeVolder <eric_devolder@yahoo.com>
To: qemu-devel@nongnu.org
Cc: Eric DeVolder <eric_devolder@yahoo.com>
Subject: [PATCH] target/m68k: Clear SR[T] on ColdFire exception entry
Date: Tue, 10 Nov 2026 08:35:11 -0600
Message-ID: <20261110143511.479225-1-eric_devolder@yahoo.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20261110143511.479225-1-eric_devolder.ref@yahoo.com>
Received-SPF: pass client-ip=66.163.186.147;
 envelope-from=eric_devolder@yahoo.com;
 helo=sonic302-21.consmr.mail.ne1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clear the SR[T] in cf_interrupt_all() to disable tracing, like
m68k_interrupt_all() does.

Signed-off-by: Eric DeVolder <eric_devolder@yahoo.com>
---
 target/m68k/op_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 38f7a68981..65eb69f2b4 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -240,6 +240,7 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
     fmt |= sr;
 
     env->sr |= SR_S;
+    env->sr &= ~SR_T;
     if (is_hw) {
         env->sr = (env->sr & ~SR_I) | (env->pending_level << SR_I_SHIFT);
         env->sr &= ~SR_M;
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284B9C88E65
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 15:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5mAZ-00008v-Va; Sun, 13 Sep 2026 11:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1x5mAH-00007Q-PM
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 11:30:46 -0400
Received: from sonic301-21.consmr.mail.gq1.yahoo.com ([98.137.64.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1x5mAE-0003zk-KL
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 11:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1789313440; bh=WjVc1WV5HjxlepYVAOj2MxPOACO6Ln4vDXN/9QU4OGI=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To;
 b=s5U2JBr98QU6D8PWdOhGbE6czcJ35/Q5upzqJimrC9pZxJXDyVJV4dMYBB3e1U72jVYGjPWzfS2cRQ0G8kvsvMDNbVKvEOTobtGFMBsr+MvTP5E3FGyvp/DB/LXfaQP8Uq2kXQK+IMQQXpdxXEzWgYMw0H5fl6HREJpcqssbgUZGrT+WldHBM/NIVyCWSLdEPHA2KAyMdZN6NV1YHd6CKXPIcS5rZDxeGgksay3b+kEjZgHx8Nu9bEXynPBKTQfcdKSOPT52qiYXIyS6KFu0Ws1Fah75j8T56AkzVhg1Tsx0fqyzcCVe5eqr0tHX88AImKAhPOQyzaaxfMyyjmytkQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1789313440; bh=Ip8+thPGd7Mrzfd8SOzn832puZCCUDGlBUGR0cCuoTr=;
 h=X-Sonic-MF:Date:Subject:From:To:From:Subject;
 b=V6sUv46uqg4S2sXnTj5JZYij7ZtsTzuoXzFnb/JicdXFdrUuEVQtZMhd5uHCBYv8uoN5ZKFLhFz45/TlSbMWe390Qg/rboXT9I1/DmOaJWXhyQ1z7XNjgb6bIDr/Xzsvav6NJchzhSNgDHtQ9FR44ZCRUokz/i2T+MazdCOT++LXdUEWxaS1YhRiDh7/VlcrLDEuA7ZWDcXXTb3pPo9SNdPeYLT6Qo+6mOKE4AOI4NcqHIWhXA+wQfCcC9SwGGT1n8lxUWenMh1zTFUfwg0ch5IwCzp0f3rMHm/hdnyUraKARDWVWzr9uSnidzghihr9hgKXNERNxnbhUuFUja+tIg==
X-YMail-OSG: VKOP9XoVM1m7xVi__8IWekBGavhQta5fbjb6mrCYNSRpgld.VeRZC22I1HY3gKn
 57lq.ww4D0o5VNpmdoCsx8wgSEnAXbS7xSulI1CfU1jzSQ0V9z_EFI6ZOqJLEaKs9wRtVJVXGtzK
 Xk.EowitHSY73y1JUhxWigsa4DW4Ey0VFIX85PfVxufGZjwAaeAbS11sC8n3NRNSfuC3BdIUI4RX
 IHmWI1u_cFNt6VG5yDLNFhnExSiuwM3_aL607Vwa14lKjZwsh4K20lnVEfRL34aFwZTaZC6DV9N1
 6y2eBaoSS.aEvSo2U1MQR.IyR822JUk8nrA41ocX8Ud6j_7iTkI1i9MrqPCQLcMIUBSli5JLmkSs
 Sl2zDylM3Ml4lW_cBqSOVvLkbeoZbMAqstbaw36cdkAooHbyxqFcboJ60WB3qmyacPAHsoDeW_OB
 GvIEquwm0rlvw3hKoYM0BVrHQAwDnpfmD16kxNrFQ.w_x_5IIVuAFrFzQttUAnexONls7TcR5brp
 _Gdt_q1Zrdz48OV9etLCHsw_dRJoazoY7VRixw45i9_jZMikE88gtiU4XGuQ9h1cs4iLskEgjHcy
 B3KniMRYV.94k5EmfSxO3ydDrT.48vjeuhUogPgvn4Dab._.YtyWKT9dkUDybavJMWN8dRTKUA.Q
 6HLoOAuA4eQeAQ2f1mo_CP6NRjDa6SmumnYumLTz9fcUbvZJvm74ACW4MnAlBt0aCVR6fUuzrbHn
 LeC5_NAChOZBPuN_nof7.5zreXrDFk8DDx2Mbsx46jqELij_wr9xxvIHG8q52gpMuYgnIK6aQSko
 rypegAcNwzU2czVOFbZ3_vJzP5M6vZZueixvB4FgG.JHFMzpPvQMbJ6cUuoodryXJObJHuGPIfss
 PADAY5Z8eopH1pYFpgqrIvlL4BUiIgIRBX_rv5ra1dpoNN.IrJF0_aSEp2iUKfASCD.IPx_SIwoc
 nC8P9DUk1P_zKIvZuvUy64C_N_RZV1Np0k_weSiDWre7K.efIdzhlEf1VBTFphs_ausCPe8gX70C
 Djj.5Pb8d7jmbpOb7QEvOWIBMHnaNBqwZV6fnTB21kwWCoTgquZ9MzNfpv_41FF4U.6Hb.fWaAW9
 0fCNwBHIqSLsmUypf6d7qk4ZT7gKEHuqqINMpvh5oHHghSzD8OGpq3.OEB3ZH.8ZJty8OWTeRSHb
 HkkpRkaIX0A7Cc6Ul4C8UoRXjnSw6AxH0iURwScvGR6dcJ09rL.ymDwMXnrnr5R4UujrRpiF5x23
 iKhWHQ9FhtAWef.wUAZ1RJ5PHxtJ8FX6L1Ptc5ITPn6aJq5XryqR6XY5TVtWGncY.LaGOJZxn.Uy
 nJpSz0V1mTO5kLT_euYkpxfdEraBvFyBXQ7OonXzFV.RAzP_KHl81N30gXb0CG3SglpBmIUV8a7Z
 MNwx_0IYAziDwAJ.Ib22AdaJNOPr2Y4qhzAxOfYgUZHxmeqynPwN25MuAN2s2J91XWGNxQiOYIX6
 1g1Mxuqr08a99MufjG2zuDNfGkHyGR39T04b3m8R9urEU8ueVO6ZUA74rpmIiMXEdtWcyfoleEf0
 2wk8Paudnu1sm1HkdeScMRalpZeSJA6fDcG2RKPqb.2iASgUBOdzG0MAMvPv_4vjGbdRTwHKJ_wc
 wpqDvSkngYJuhFWwXZLTKi48cdGnmT1uGGivB22jc7UEHmuTuB5eCiSjHtZ5YJwbZriKGgHX_.A7
 ptckyBlNghrC3F6um99EvZ9LtFQ9ihUTtSyIYSAp4A23LjeSuHSvldtn2aYgloTkkVp5XLqGmlAL
 UhVkzgKz4FQFNBX1U6PeD8co9_3bnpzhVqK9_g1YtsXmgR1bz41I.7MCHPn7Q4BwgXlg_GELM4TP
 wla7lRVfH_WzD8eumfZVpCgX74Ph84AIjkSM_NfzJQwzILov5jv68iklKoRlOwTn3D16Z8ZPI2Ax
 KgjmUGZGRO.MrgoupAapPheQNJ8bLNuCbYPHhwmyCGTHqdIC7gM5rdcAmbCP.OtLPWCAOPCCQP3e
 eV6d_7QbUAb7DKnbTR.bHlXz8knfVqV.wSXM77qG_OnAbQv.BvLEcwzSBwvhajBE1SAPRtmjL1Wm
 RVkQMaBqLDAQWyK.zO270s_YPtb_eoEbjYu5WU8mZAiGSucOak8W2BWR1hTzPuwopFN44RakS7ba
 .4o4wsEIckQLKG6sJyNIxyy.xQQQmCHlsyJByzlJVNJGms0dKhHZz.dND1KmMRwX9Sz1ENkIflWh
 21Gv0rLl1fv3zozVKDdSHimFPJ.Fr74ATxP1vL45FeVtH
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: ab88ba77-23ca-4dcf-88d5-66067669b80b
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sun, 13 Sep 2026 15:30:40 +0000
Received: by hermes--production-bf1-54b5569bdc-kpwjr (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID b73119bad5fb74a8759bef838f1a5a2f; 
 Sun, 13 Sep 2026 15:30:37 +0000 (UTC)
Message-ID: <59c57e60-a677-4ae6-938f-fc533ca82468@aol.com>
Date: Sun, 13 Sep 2026 11:30:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] xen/igd: implement support for extended VBT
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
References: <20260911072453.46256-1-brchuckz@aol.com>
 <20260911072453.46256-7-brchuckz@aol.com>
Content-Language: en-US
In-Reply-To: <20260911072453.46256-7-brchuckz@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26525
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.64.147; envelope-from=brchuckz@aol.com;
 helo=sonic301-21.consmr.mail.gq1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
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

On 9/11/2026 3:24 AM, Chuck Zmudzinski wrote:
> --- snip ---
> The companion patch to hvmloader will be posted to the xen-devel and qemu-devel
> mailing lists shortly after this patch is posted. It is v3 of the patch
> "tools/hvmloader: implement Intel IGD extended VBT support". Please note that
> previous versions of that patch to hvmloader are not compatible with this
> patch.

The companion patch to hvmloader that is needed for this patch to take effect
has been upgraded to v4 and is available here:

https://lore.kernel.org/xen-devel/20260913032724.62438-2-brchuckz@aol.com/


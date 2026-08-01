Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CBFC55172
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 11:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wq8Fd-0006D2-Ox; Sat, 01 Aug 2026 07:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@netscape.net>)
 id 1wq8FX-0006Cb-Eo
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 07:51:32 -0400
Received: from sonic305-19.consmr.mail.gq1.yahoo.com ([98.137.64.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@netscape.net>)
 id 1wq8FV-0002mV-6D
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 07:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048;
 t=1785585084; bh=fuiv5o+ZM6uC/qcEX+Tzmuq7yIkIt71ND7aoktB7eoE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=RzrSTEwcS6DdKfMZCyRalp4+SYc+zLSn8i0BDw8EJ+IqKSwtQ1YC+E0i6jvhUQoITreHxMMhubTFv4mH2Ap8VX9CbBDfZ8NXyBRuoneFABkpJc1reVMd58iEZhNqnRaCczrNAsZtt8y/9qGKxgvfyix0Eoq+rF/553X9Xro36R6GtG0EQs4Pk0Sr+HpKaRBMHd5ejBk5I0Z6BXRzF3CR7IeWCOM1z59aMWsBuXmNtZ5vFFyTqivcQ+zUChOpac12c+UqItZv1Fq5D++lAGwk+9PolsLHWhBq6sgc2nTkiy6EmfoCV9EWxlJhBUnZVMwYaJIfcEQ/JDf0UX5IQ0V6TQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785585084; bh=N1KTBtU3ESCjUWEFdgsobkxQoc0Bd7zyUuVx50lfR4k=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=tCOVNGsXenhDGDx13ti0hjjT5Fs2Z6Mksu2Gftu24N4xBrQi5XSgDRMFcvp//TNG7iGPuWZd2P3RwTUOAZAqtjBa2X2NHEBr7YVLCeH2nkOYsTswBZ1353sjNFHKefJ2dBelpLB+tDIT1P8s/IbC+hXJRG2jYxsU//oyovSNKCsBQCELHot33BAUB7bXG42NwR/Wze15/sVLeWL1qSLUwPXrZ8To8kp6f5k1QBdmofIE5sAvTLTky4woa7a3vzxJiIxNygE70jwUCZPhkojEUH4DFPWsqirUqPhYlSjsYsDs1re1oKjFxpL50dihFJ4KarLybkbkm1cIIch5L1L7uA==
X-YMail-OSG: aKsnXoYVM1msTfRexnj39EqPGrx117cWtsOWgBMvH8i.wtCxTTdrSq.xKjIGhhO
 8lTaENnx.Xo71QG6aCfadwl10j5BWRCUFbZEmBK8nYFnJZPGqjzykIdoVlFJkhPgS7dO63IARVSe
 hnMAnDINxz9zG8vu7rUw2QIK9Xf7AcWXeuAMA7bSoKauxYxW9lii_CUX5t887g_wPE_dQo9SKXBF
 Yg3DWRVLAGXozWK4kXSr1OeSkNQGesu4y9tQ1YPKzy.lah4ydU7YYJ0Qzw7nRRHAT955kteiHpJB
 O2J3Wdd3ZzPsS1WgFA9rU7cq8UUSEdVv_0UCbxFlb_6Phzqa52c8Rd8w4zka8TQhirkXjxeqWGgC
 PfDVuu21XHzEoClVppiJdeYPi4oymsTjEbCuWpsuTkY8DDLuN5KBX9YZC28PsDniiiip1NoH5a4_
 NBiVYKNq7yRvnNLGiEbKdzeZ4u.6A1oDK25PH0AxbntTQisb8B10lp3j02Df_E6xp4N8Qzwa72jY
 duJZv14j_26ufz6sYMbknq8HfAjdXna9sd7W.ezfzqx7Np574d76tdlESBD7xIBdCSMV8hR7b70k
 qaSYI2HWBozE9Lt0DvXBm0AK6eVeGn1u9BVcxBiKE4emHqSvdtO4AELZEpLksHCIb7WzGWyipR2J
 1Nm4gRF6IFyyLBxLK94NbZA_Vfs.KJSkL_AMpj3eAK.lBnvDcU1zqVrmyBCG2Mjgkn2UggHHyhaR
 4RXSjRYc.R8194Q9N3_Fnk5PFJh9wv_A41hE3FgWG0LcN8CJR_YsqquLMfz9xEm7IcKqmylpoK33
 AHXzR5nSsR.0xsC.A9McnS79jd2X77yu0zX5rhec5oSjxR9eS46lZJ3Rtxpi8mvRnHskGfKCkER1
 drpBotZBSKUy911Q81Yf4YHRF.KSIa68On7FVAJGyGlIzGRoRsUbJnjXeZqxnIE7vOaNHo8uf_QQ
 xIgtGyDAPe2hSf6OEUhUDVL0lpIxOsSQ70cI2PfYNezQ1KHk3.HGH6shG3rZWZ6mn0IYRtqPktFF
 LgFFwwwK7FmobjmNT19pvsUv8C0EJ_588HWu38pBwSesiDWM.Rja_m4CHfNVBDTE9xj06yW.GfjF
 8WZf.HwaSVvE4C_MpYKm4DIURVWq44GwjYJzwgiLCQKlKhFfzXKVAnsQgKCr9gdg7NlHifqve6h_
 MtOlBADM9Lawz0A9XYGhQ9vwvZjkIe.ae_s6nDqYMNi2AwOpLgrPTDgvukQmexdym3tx7Elpz9vF
 qtiQUpOarTaXtGaec3879KS.e.CoD3LkwWX28b1sEuwuxQOX1GCaiJYgV9hRIXrK9xZ56iV7MciI
 ORNQUdBt27x2zjlwwhyYCBRgLw7tTG61fGj8y9OQmfLskMi8nwtzDyH4M_eLLPgXC6TdvhC3ACbf
 ohN05lM.10W.u5mVmnUopLpl.8z33pOLEqqaQYIfQcIuS4TEuDCbY9z.qBvhfRBvH11EjtG77n6T
 D5Tt0iAMyw4MyvzgYri3ffFMG_sSzgBPAAlx85U7jcDooFaUiMFajhiBnlXPqhAYgpsEQnkudmJ6
 VKV4a6T9m0Fzr.CEII_QtUOJC9vTNly3zXYz2sdkMeJtcgOQv64hurf4qbsv0SZBF.ohrzBziImy
 RcfHR2oY9fnTxuRzZMtjZonw9uaTfXkmnwFMZ1d2Ln.K7OHrFo3J0ZbrTQzpH1ODkudlLkO6yfLM
 0W1nIl470Fyl1oLUajyErKVDdp5wg47TzCmtqgrNotvvrl.IDEP3BBFvI.4iyQdSbMH.1f7rjKtt
 ELkUF4MQ3Ey_4Jw7dtJFwtJ1iSdbk_3hENT7LcrJKztteNQREAr5PEJwPx2mQDHaOX28y8Q7X1mR
 2nHLW8oeNxwKD8wNhM1BxLNJ1fysYkWDMVGjCd3u0K2kpYvuCEkyJCnmIofToOvHHhoK0TXXIIXc
 0scGm5z2JvQCXTZpG75wKaFd71l4ykoyNdK7tbs8BqL2F0_lEv0gxnhgxoeyuHh.hjqv5ncyunKT
 JyDOuGV_Ze2_sPIcQJUSIj7EHOiKOxK5C1pE..VP9gE28WCkTapNCpmxgU5mf1yxmD53OAazKudJ
 R753iIExk0QwgcKhQL8YyX1q2vFoHOeiXpPAH6RemvB9XQ26Pzwmo8R23nkVhD7GW9ntvJ2wJabJ
 IT7vxFkCTAlqVQq.PWsw8MO6Zsr3M6g65YYrKD2yARUoymbqYhHYK9ohd0_RhF9GzXDSeIhhkcwE
 oYn6aytZTzy2z1Yivb0zaqBfRGbEBlbHYxM3hIA1D0wHq0EdXJgc.G4CjL_YVO_h5
X-Sonic-MF: <brchuckz@netscape.net>
X-Sonic-ID: cf8f62cc-639d-4ae9-8f4f-fa4e168ee8ab
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.gq1.yahoo.com with HTTP; Sat, 1 Aug 2026 11:51:24 +0000
Received: by hermes--production-ne1-6f6bdbdd7c-jtc22 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 2c6e9c6518a5b71581c74d9ac6047a6d; 
 Sat, 01 Aug 2026 11:51:20 +0000 (UTC)
Message-ID: <1418735a-2ed4-4f89-a9e4-631f5423608d@netscape.net>
Date: Sat, 1 Aug 2026 07:51:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] xen/igd: use custom option ROM if provided
To: Chuck Zmudzinski <brchuckz@aol.com>, qemu-devel@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Jan Beulich <jbeulich@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>
References: <20260801001737.16509-1-brchuckz@aol.com>
 <20260801001737.16509-7-brchuckz@aol.com>
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <20260801001737.16509-7-brchuckz@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26215
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.64.82; envelope-from=brchuckz@netscape.net;
 helo=sonic305-19.consmr.mail.gq1.yahoo.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/31/2026 8:17 PM, Chuck Zmudzinski wrote:

> 
> As mentioned in the message accompanying Patch 4 of this patchset,
> the official edk2 project does not provide support for the Intel
> IGD, but some OVMF patches for Intel IGD support are available
> online for KVM/VFIO guests, such as at the links below (they apply
> to the OvmfPkgX64 platform):
> 
> https://github.com/cmd2001/build-edk2-gvtd
> https://eci.intel.com/docs/3.3/components/kvm-hypervisor.html#build-ovmf-fd-for-kvm
> https://github.com/LongQT-sea/intel-igpu-passthru

And also from Tomita:

https://github.com/tomitamoeko/VfioIgdPkg

Thanks, Tomita!

> 
> With such patches it is reported that the passed through Intel
> IGD device lights up the display during early boot from OVMF
> and the guest bootloader in KVM/VFIO guests provided that the
> administrator provides the correct ROM file via the 'romfile'
> setting for the passed thorugh Intel iGD device and applies
> appropriate patches to the OvmfPkgX64 platform.
> 
> It should also be possible to add Intel IGD support for the OvmfXen
> platform also but I have not seen any such patches online for OvmfXen
> and if anyone knows of such patches online I would be interested to
> be informed about them. I am also working on my own patches to
> add Intel IGD support to the OvmfXen platform, in private for now.
> If anyone is interested, I can make the work I have done so far
> toward this goal avalable online.
> 


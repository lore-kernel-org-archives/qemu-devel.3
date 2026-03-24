Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2CFFEC0F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w572l-00082X-Ue; Tue, 24 Mar 2026 15:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xypron.glpk@gmx.de>)
 id 1w572j-000828-PC
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:03:57 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xypron.glpk@gmx.de>)
 id 1w572h-0007eO-8R
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1774379032; x=1774983832; i=xypron.glpk@gmx.de;
 bh=uKcYdpRjN0UanpLR7MQXAl7lsHN+nWqAYBfdT5n42C0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Lv0Y5rkuIi4Htp0L3tBIYvl8mK2p67/uhkEjMnj6BVc3w/mg767wrcOH860ct6Kw
 voMUAGF+XtbCY0PXPJjgOmu/Y6lxH1BrKO8yiUDrGQujM/NGE16aF7vkhusJuPoo0
 E1ieuwbAA2U4UYGy6AFuNNl7iEhMQoNds5IPAZnGaCFk+OXeKVqrWsDDbYXw8vy5v
 fV74q7bSyJ1ckfohHzjKdsbGp4BKoLzRZHMvVrM8O/c/7M4qXV/CsM6vf8QYKJV5x
 RuaB0Cs+EKrcI4o+wxPSZ+rLA5R/rUwMgTAp2SbWHV6AwUlOxHmhyK3rF/6xtLlNo
 MXfR/ab7W33MaDzLMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b6b-1wD7O11dhV-00HCtj; Tue, 24
 Mar 2026 20:03:52 +0100
Date: Tue, 24 Mar 2026 20:03:48 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, u-boot@lists.denx.de
CC: rick@andestech.com, ycliang@andestech.com, trini@konsulko.com, me@ziyao.cc,
 anshuld@ti.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] riscv: andes: Add Smstateen extension support
User-Agent: Thunderbird for Android
In-Reply-To: <20260319082911.3270255-2-ycliang@andestech.com>
References: <20260319082911.3270255-1-ycliang@andestech.com>
 <20260319082911.3270255-2-ycliang@andestech.com>
Message-ID: <203AE23D-AC3C-409D-B79C-8FF631D828E3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lQH5iBCaD3g3TybEDMcgc4d9nuR6Ogcsfj2SckPcfZMEFITg6XJ
 dy4bLEIXtSGGPQxvCwWK2qb01wRsOcFEz19FLqysNZz40KBBl18/hQ5zwcQYCA7oy7VkyXF
 dCOoF5PY9SYbj/50Jv3aZk/AyyG6L7zTWRQQnHxglarbFxtwWn2R9ht72/5c0vO66uVM6QZ
 ppvyH72bcxMM1V0ZG0B9g==
UI-OutboundReport: notjunk:1;M01:P0:NGRyPFwY/SM=;QrlOg3OYiSLCN9rBNTRQVhu46ZY
 Hi3hl8RtqznQytjWOy+FDbt4FIf+hpJ6j6Qi/NsaZiKR9J4CO0349w7Cw3guN+8KwKT5oTxfM
 dPaCM+oWgEMdB/Rslrf+oj/QgwP1b7QRufn+5CgHglqA+bKAhsgk2SojcpMzqV66C3rXxYuVw
 Uw8D+yKxlLmphnxSA1ZAmOr0ulWBZgjBbInlAUHzZa7sSPqGDK6gkovGXfY3VEG3xK0+560qN
 7Bw+k2V1JBxpFcrZMvXzvbOCOPEsVNRUlJueZjTexRfAaRsiz7zKxDny0n3A2ZjYE3e7JaFFP
 Aze8Q0yX8ktbHNJkGeMPDVjhwJkZME+0hz3J84hsq1LFD7tJHK5kZW2IcCYceJUOW+7ACdtjt
 UW4NthU8omqrUMe9JcBTLanqFiZ+9Ixj+dVGjdSa5d9K9m03V8qOqyK6YhNCtciO8OfBaqMOH
 trv4j8Rm278ZLUTvPR7/qyVo3uVUl949Sm0GYeyapJdvEX1DBXMgiR+RnGbsRm17xe0pXRV2s
 T941LLAESxQom0cSMEltfYjhqFqHJXzHXY4OL8c9/V1u9qaX6RKfq8DLfUhFj3aq9JHdAh8NB
 N64L7qHNHLQ6wMAfgjnjxhv0jIVOqnLLsmOH6ncxMvZ5Dv+2O1hQ06PoHThfJRSgJBnzH8J4m
 5bcHwbAkoElaCMcG+I3+hiygBrelFDpO/s7AoZWGB0eoIeLkpLnbkecuqhyhfHI+kA109oX/A
 UXXkH+TKQiJv8OR8iiRwpioQ1xllN8J30ABMd7sgvOjlMESo/J6IZNx5hDFv4apQG2ljbaRZ8
 cj5sZnd3ZES6cOYpFRKeCL7w/7oSm46uClUkZ/fuCs9/uXTJxUiX1A9TxRIg5kQCJ4VwOywFs
 rK118Lh3+qgs9DqpaqD56kf+9vUF0jNIW9IZopjmUzD5RMQuS3zGOljSHLYvDdB8bhNd/tUh/
 1oxPlnQBz9Z4osWWFC1LFZjJyl80g7WUdt7zxBVuCMu1qA9Y6Qpye635VJ2cvqIl5JxHMYEyd
 rdjREXREnoadv9GSu4fktzgQBRWu6sKjgOCmQvqFzmimx9Qesj9N3eBr9FpK9XUu7Apg8mGnT
 iPSLUypl1xbxF0hD/LjCv3LlTRCXeSj/koO1WDXAlQj71y+439eHCpgvkH7JK6jeqbBcthX+n
 /cVijCWwtXrRfB1qjf7HEdzY4/dY9OP1d5M+dO1i5yuNtLRvhhgpDLDB983zoSU1VYcfXQOBu
 XE5HL4unR7pZWO+GZGLyV2rRo1N6BsN8EEvEIbAKEVG+yzcQF52Jd6fsxEgnADhHdSrmcTz3C
 UKGvCs91YOa9WQ+M9vbpu8OPHp8+QHGcoBhfexRM6DbtXciZ8zQtCtNCAzdFrCb6fWxk0xjpp
 PA9qOftjbxa54pEb/q6piJsBYCZKiYnO20hY7/a+KTv9jMqRb29J5kXthk0aUeqJ5TWXEu7HD
 Lm21LfcV1pZm3xm7mwjRVLa8AFqPYkqYa3NOzpuH0RDAyevQSva3iSj8xrg7Q6lQ6rHWolLgS
 4YbBul5+AZviiSCh9xU8vjfJFqDHDpZk5yySYblDnEEErm89mxTQ/ux729ZMFjD3Alw4aZy8/
 aMbBVjEWlW/fJklqJOcxbTfu0XxPSafFYm57nx5o1urvl17esuemx5Z1n1mKSZSSmd6dzXJrm
 /ye/CSGdz/Po0XGK6WGDS08qHcekqYuV1djElQ/9M12OJseqo25HsiPo6t1yerSYOo2ZKmzQc
 OjANPysd04xsDNnGuiJ7qCNmVaSBhBDFW7juEwwd+WtmZSdqXqct3ubL1J5hHu7TRCWjrm8/b
 EjyJ78GzWydDYgLRKMcsh573ZROroEU5GzNFDYodkJdVGF1TuEmyvdiKfCz112b2HnYu1JUIt
 R9YcBrOdnbL+SnWwE71xqQhQvLifZtsTbu1lpTmOlP0FBvkj8vS1C/DViZ4CiTaFhpgZH1APX
 bW6k6gRyvwQSvhjawwe/QGoWsS8SRr64Mv+jMjdP+KGIxr/bWluAlX0K8AJ4/9l988y5VWH4r
 TqtUhdxVC9alueMJoDrBSFOhUmT67oGSNgg2M8pi8xiv7iuSmu1eJYBr8LsBGYYTTXwNFZ44w
 u8qIr2riGAby2/QMXUOG6gPJj3xScfoQYzu08OfIqbbI2HiohsK8zdxCr03YIwwYznEEs9vOP
 7LRPcatRWzvaLNcR3VaI+7VqDj1y06GXeUAgKyh767W1+v1wFfmo5w+E3VbYLJ/bfg0dQSb/S
 xhUoLpXlmfiA4kPCZqUaSYgHSZSj+PyFqhDOxmfOm1XZcrIBW5kcJfxLv5DnhIPFWjPxSVqbI
 QE03Pg9ch36GTWcP+OqnJ4p02O4pnOSQLbbCHMZBTERt6BpGXN9EKOP7m2qN6RIxcRMxIs+4l
 5/+G0gS4IdvsXLGMW5cYMmJJtU8+DJXNT9EGAxQn0kdC3TWujd49SDQKAaa11BLpY4O+dPDRl
 58kW3UGYSXeAvzHOoq3R9NykN8CsUGfZ//kL43DVMpEDcjiFN/rKK8Hu43PkTPhouK943nGE8
 ysr6q4ufdE6kVMF1L3m1MQhvRXptHj38D13JEfTGRLHKuRVu1zBD47DIjr1PfNU3/RbMeciVI
 i5m6SwpRd53efVe269NybGYgmkaqA0BbTkHkvD0u8Qraq1ff/P7rnt0fgvkhQirvtyoCGmMF+
 /S8FRMZTjRaniJeEIX4x48kjwKKVcDimc2CsaLmtbLO1qoKhQWkHILU77NDBnbOcVIfpZty7x
 hnXHRJQd2l5E/WkIOp+5yzxo7YabUzCfYc+KMg2nT5negNzCUzYV5Klcc5WHPEZBC89vUNOcH
 HyNlowh+G+CB1AdLje4Byyxlzmlu7tW34eRi8hmfDZIQv7CDHAIzu+DY4uWue/GDtO4DXac5w
 POEUn1qVyHxnyJhIb+BzGE0USYmlfVYOsCnDvdEZ3WHFrl4xzKHfqo60cv9woBA7qD4byxqLi
 g7vBpJU2EbUD3DnLhqY0sT39tA0bDcu1wxHBcuP7KiKjzkbC8mtk2WXV5a4UsMdhJHM5n7zWQ
 eh2CHAzvocrkvydj5suRBgxN+WtBEN9DAzgdu2omSgi67D9Q7IdDPYfWcgeKq0UOeLeTqZeiK
 wynGzvxU4NcxgOO1McKarp42lYRqEunN/rFVpekXW8Rog/jIa5Cg+36u0mrJNzP+9gwES6Djh
 ZEnJCjFTEYlR0kSARW3O8gvgQtsYm4xp/7ORh+gC0+F7WgIpZvguQF9IfmPtjUXN7IKdlJ1J2
 jsUs9cIt+uOAZ+86OxSGRhBqoH03a7WbtvYi/c9qcVCjrVDnSbjaE12fWKCy9bpjW8Tn2Tgo6
 s80CwgHNtlNQhbmMXJAEV0sm0wOGvnJqco6vNL3micWqbL5HjJ1JxEEr9fOfuXhZVQmvRLfqj
 c+oTE7OhG+xnSsi5dOGQitY8neXtSO1cpgvGa3w3xJE9txdypHw4HrkNLHslotkKhRlowwoL5
 VRR0warklgFRn7gU5bi4w6QLJA1FLiP1K9TxBKYPAWliH9VHdy80NlR4YSHRCbWx/6qI0mApG
 QA0DrUkVBH9ZSG6MjrT/sGyGtqszPEEkcCXfE7J2fgkKZkSBwhFZtIOV3m0QMzUW5lLsgUV/I
 YTLS3vwxtEx4Tu5IP7dpSqc3ebKhRFJ99znnB4RKzuj7c6vsRnhYKa1C5e/HX7Yoq+2Up+h+/
 2exep73hti1zRiXBeyH+M/Urcy9AJd13ndl1y6MNnuVa7t7lCb4oC4VnGWXv7tkkGirdp/BhK
 H6m803IvCCzW7/qToA3f5IGrZdQnChPVA8l8OGfZRRi3hpW4JkGGtyqiHYLmBGO5wCiqiFekL
 llONqvmoiaSd3kYtLZfOPF7kS2/OajCYn8NRr03zj4ly/5dmY/OVLw16b7V1/q6kXVyMP//rX
 ty2WB4FlPOxa6EmIMTG/fI8SgiQU1x6fC+Jun5KaGtrr2nHSkmr1lhvVy62tOtTNUUTDWt8sP
 l5PNTmD2xDIn5KOlLLbRZvpePeXkdHP5fPxvDDkrukDKog6f2xAtKOfZK5TDnoKccUVb0aC3r
 sB7UsTBp7viBXRkMDAhMwE515uvGlmHmsXUUYaP/wgJCJ/ndwM+z1ox0dnsluHw7Mx4KnY0mf
 D2yLrtvsJBnr8P8xL6QT8S8yucnhqtHaPMFJWSDwXZPgQtQykWDpg/0v251G4a5sboBGIqxE/
 7tiRYAT5tnZJVzmYqzjCV9Y9wkopiUGuG8JmySSDrKn56XEUHScgwmVAV2e5Qdy2quMOSQCLQ
 OjUqo2BlLsJl9b4R7Yn1BoumJ0kwQjv0If0UQgQeyspmsqC8Uoy+mb6l5Xmkyky5QNGk6Artr
 CitUJAdrhaU/U3SUMeUYpt0gi6cjOxRJPOzbEYRFLBQAVH8xGSxpVx0MLJQsgWicsMzatHkt+
 dTp8B6t6Gxi4d6/nP9/zCLqudxpBCoiCZwvilXYhKGt8METe0VTG4uR1Ete5Xvxm6Yl6r8fX7
 tkVi7rKXAlVKUolI2AzTZS45y5AL9zk3U2AN1t8IZvQbopT1km0GkPANi29g7JejWmGvze5Ho
 J4MtvK09XHSNyiq0WTLQkbNFvJc6IGMa3sKqfIWZqHjyyJGPQzGJZCBhplTrtBu8cVCdIFpza
 9kmF6ippd2b/Fw4qWRJ9uGbOcs1PiuJ9K1Bo+9XcT5iKlXzAIEQu7kURYb7sNddkp5GuEZNHf
 xtkFC8H0mC0p0yrzwbz717ufX5iwS/gAec33rOLtRzD9tXPzAoSmbrZ1+dRGgfGgCIgTdeQ78
 a3orVkEEImY5xqrEIc0d5xbgL2Fy1s4LYT3tkT4mqyX2oLZHwwJuIsY01qP2ZhD69N63nyZmn
 GDwlRCxbBLGFpBdWV2PphIyPbZS/N6zf/CTXwcIwJeZdwnDq7qa48jMRQeNd01esxvLW0vkoI
 U5oY6ALluyseY/vDLr3BBRVJgwHOdpEvVccBSEuJDmipFBnysdKe3zNVzg1T1AFT1AFsNA+ao
 oC119RJFP+tJGsQmB6LtArmZ4/D1uTrgV6Zwp+CIArJmS6kZXUTQho/ZbrZ504oDt1cc86RYE
 Xn67MOSAFmrZvmMwtIo7cyrJnU+k5B0fz0ZrR2MfmOft8idl9tkApQyddtF5XONo0ct/MS94B
 BKlZytk2ogw6xbD0G40BNeVyW/6/akqoJK9b+tbdWsRDu+79pY+SyGjDAMQVn2xr+EqqTkEkj
 XABbH5PYZjqDw+oMGsHCs7kf3hJoZ91DQoMYGR+WbP9Y4embUl02HWipJKKo/UB5B9ObmGVzd
 bpz+N1tC74D3DF3MIwWsPu+O2Q16cj3/QI2RpkVQXVSZ1i9mIy6Bq8+vfXpXuwfMzKVZOJBYo
 3xVBlhqZED98vCdp+LUYIjZwL6SVWtzTGpz9dWp02F7o+GBQru4h3fYKr20Ml+L6X90R3z9YA
 7shCGMjne9D3jYJTZvtqkp1ZLCGmrllscEUMmUTN0dtr0=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=xypron.glpk@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 19=2E M=C3=A4rz 2026 09:29:11 MEZ schrieb Leo Yu-Chi Liang <ycliang@ande=
stech=2Ecom>:
>Use the CSR detection mechanism to probe for the Smstateen extension
>and initialize mstateen0/sstateen0 CSRs when present=2E
>
>The mstateen0 register is configured to allow S-mode access to fcsr,
>AIA, IMSIC, indirect CSR access, environment configuration, and
>sstateen0=2E The sstateen0 register enables U-mode access to compressed
>extension state and fcsr=2E
>
>Supports both RV32 (using MSTATEEN0/MSTATEEN0H split) and RV64=2E

Why is this change needed in U-Boot?
Does EDK II do the same?
Isn't this the kernel's job?

Best regards

Heinrich

>
>Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech=2Ecom>
>---
> arch/riscv/cpu/andes/cpu=2Ec   | 29 +++++++++++++++++++++++++++++
> arch/riscv/include/asm/csr=2Eh | 15 +++++++++++++++
> 2 files changed, 44 insertions(+)
>
>diff --git a/arch/riscv/cpu/andes/cpu=2Ec b/arch/riscv/cpu/andes/cpu=2Ec
>index d25ecba0e88=2E=2Efeb755a4f0d 100644
>--- a/arch/riscv/cpu/andes/cpu=2Ec
>+++ b/arch/riscv/cpu/andes/cpu=2Ec
>@@ -9,6 +9,7 @@
> #include <irq_func=2Eh>
> #include <asm/cache=2Eh>
> #include <asm/csr=2Eh>
>+#include <asm/csr_detect=2Eh>
> #include <asm/arch-andes/csr=2Eh>
>=20
> /*
>@@ -60,5 +61,33 @@ void harts_early_init(void)
> 		mmisc_ctl_val |=3D MMISC_CTL_NON_BLOCKING_EN;
>=20
> 		csr_write(CSR_MMISC_CTL, mmisc_ctl_val);
>+
>+		/* Initialize Smstateen if the extension is present */
>+		{
>+			int trap =3D 0;
>+			unsigned long long mstateen0;
>+
>+			mstateen0 =3D csr_read_allowed(CSR_MSTATEEN0, trap);
>+			if (!trap) {
>+#if __riscv_xlen =3D=3D 32
>+				mstateen0 |=3D (unsigned long long)
>+					csr_read(CSR_MSTATEEN0H) << 32;
>+#endif
>+				mstateen0 |=3D SMSTATEEN0_CS | SMSTATEEN0_FCSR |
>+					     SMSTATEEN0_CONTEXT |
>+					     SMSTATEEN0_IMSIC |
>+					     SMSTATEEN0_AIA |
>+					     SMSTATEEN0_CSRIND |
>+					     SMSTATEEN0_ENVCFG |
>+					     SMSTATEEN0_SE0;
>+				csr_write(CSR_MSTATEEN0, mstateen0);
>+#if __riscv_xlen =3D=3D 32
>+				csr_write(CSR_MSTATEEN0H, mstateen0 >> 32);
>+#endif
>+				csr_write(CSR_SSTATEEN0,
>+					  csr_read(CSR_SSTATEEN0) |
>+					  SMSTATEEN0_CS | SMSTATEEN0_FCSR);
>+			}
>+		}
> 	}
> }
>diff --git a/arch/riscv/include/asm/csr=2Eh b/arch/riscv/include/asm/csr=
=2Eh
>index 986f951c31a=2E=2Ecef0fd906da 100644
>--- a/arch/riscv/include/asm/csr=2Eh
>+++ b/arch/riscv/include/asm/csr=2Eh
>@@ -97,6 +97,18 @@
> #define SIE_STIE		(_AC(0x1, UL) << IRQ_S_TIMER)
> #define SIE_SEIE		(_AC(0x1, UL) << IRQ_S_EXT)
>=20
>+/* Smstateen: mstateen0 / sstateen0 bit definitions */
>+#define SMSTATEEN0_CS		(_AC(0x1, ULL) << 0)
>+#define SMSTATEEN0_FCSR		(_AC(0x1, ULL) << 1)
>+#define SMSTATEEN0_JVT		(_AC(0x1, ULL) << 2)
>+#define SMSTATEEN0_CONTEXT	(_AC(0x1, ULL) << 57)
>+#define SMSTATEEN0_IMSIC	(_AC(0x1, ULL) << 58)
>+#define SMSTATEEN0_AIA		(_AC(0x1, ULL) << 59)
>+#define SMSTATEEN0_CSRIND	(_AC(0x1, ULL) << 60)
>+#define SMSTATEEN0_P1P13	(_AC(0x1, ULL) << 61)
>+#define SMSTATEEN0_ENVCFG	(_AC(0x1, ULL) << 62)
>+#define SMSTATEEN0_SE0		(_AC(0x1, ULL) << 63)
>+
> #define CSR_FCSR		0x003
> #define CSR_CYCLE		0xc00
> #define CSR_TIME		0xc01
>@@ -105,6 +117,7 @@
> #define CSR_SIE			0x104
> #define CSR_STVEC		0x105
> #define CSR_SCOUNTEREN		0x106
>+#define CSR_SSTATEEN0		0x10c
> #define CSR_SSCRATCH		0x140
> #define CSR_SEPC		0x141
> #define CSR_SCAUSE		0x142
>@@ -126,6 +139,8 @@
> #else
> #define CSR_MCOUNTEREN		0x306
> #endif
>+#define CSR_MSTATEEN0		0x30c
>+#define CSR_MSTATEEN0H		0x31c
> #define CSR_MSCRATCH		0x340
> #define CSR_MEPC		0x341
> #define CSR_MCAUSE		0x342



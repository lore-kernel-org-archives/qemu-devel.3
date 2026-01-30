Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328D0E6BF08
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnOl-00046A-0X; Fri, 30 Jan 2026 07:14:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOi-0003cv-Rd
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:48 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOh-0001uc-36
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769775273; x=1770380073; i=lukasstraub2@web.de;
 bh=t+IVG6q6GMuhSVJiTxbLMi2Hw4Y0ya/nW8pJdOBTdvs=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=eMvXpqvtbqss8fwxuglLtOclnZmPin0Kitnui5nEDmYX9MpQKVEDW/JCHOOxPIg9
 EE0ALneXKzTJL7aPlsC9lV5ofQ/2G6IybqpYg/sG8B0tIfDl7doWZuLNdrWoJikAV
 hghsJWHxQSVfVXGNuu/D+ivjLeBGtgsXK6oj9oMHf4SsZNd/wAFXVpjoq1EtRWt3q
 wUGvX0+Z+RV+ucOS/zt0soMemfZw5MNm94ailkHUzu8u5PKqXtFEq6QEB1AImkkO1
 wOgjiCLDuQGBeaMD8dBGYWqNuvVr61UsU7eHJ/OxjnGduBW6cUYwqHTPmsGEVqxzJ
 ycithe1aCfdO2a9PSw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmho4-1wBTh92teg-00bIxa; Fri, 30
 Jan 2026 13:14:33 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 30 Jan 2026 13:14:09 +0100
Subject: [PATCH v4 01/16] MAINTAINERS: Add myself as maintainer for COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260130-colo_unit_test_multifd-v4-1-7115ab6f0e77@web.de>
References: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
In-Reply-To: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=637; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=cgrowfT3fdAg+LolXqDjAFU8mfr9pDNB8HODvZTMyxo=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpfKClncT1jG38r6UwuigStfhAJRrFMVoKmqvG0
 hGD51Jwyo2JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXygpQAKCRA1qwsonF2y
 WMCxEACayWNefvCyHKHyli/0I2p5g5kqjVdIFy37HVFghHxiIrEafWU8YACeqmFfZwCGo8arXaR
 FD3zB0/onUkelgEq/c69i3BwCIQQ+8FAfC28UNoM3OQ8/jTbARyRv5DeW4NN376E+eLgyWOChmp
 3EmK4ckZn8T9BJxhJQnHwE0bpElUg7gugcwF3ic6hC3T0pGc6z96Mb2KenyZq1IVDqQAaIs61qP
 gsi5a1XYtKphycEVsvtcf1YU15polC/yC9Nqr+eFbfa0lq9lVOgyeGgMvSHqevDWHyMpe5zV9Yf
 xKhqJyvUf654Ff3HPUaR0ysAI7rMjfEamTTortzJsa83z9X4Iwc6rMZIyytuXTQqVDRmuC0qCca
 tp4JvOX9WF91/OQGZTbL9AKPz1rDJoryC/RmEznfYGTZEF9xeGteyKgUJwIr1CXrg0XiNLemX0I
 n62zg9LPxPDGlWT3oXrDwy7fi5lOadz5r9pT9/2zy9dB7NZhWqIBb7BLXR/e7p0HYFaPS6Q6yz+
 l/QXHl6tCy7V9uU/T+cniwvLfSvRoMn470Ydv4/GmLAgy6OvQ4cYMFbb0iKeRNVFULgwb2F+wZY
 HMsKgkaYqMMTOUD5hIBiC7oBl56SJT+5FJ4gZxb8NFrJcfU7tTvBw1VhYho3DX4//VK2XHAJfMy
 cBGaq6/sQr41gFg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:pJTFS/kg4IdgSK8uFs0GTaJ5HhGLIT0Jr9xKW+cPdoRv67C5tWr
 vNBdkJUHr/fgkubIApxOSpgtiKY/ZfF/81hf9fPCAB7KA2OLRAmB18Xsp4RaPyTnatLs3NA
 +xf402of5OV803VGsVyK/YOsdMdF3vehBhTy/cZ/gtfj70Tn05KZFwmNvdzHNsgB01zv2wd
 SP+0BJm0UjBCF9lBEI0mw==
UI-OutboundReport: notjunk:1;M01:P0:iqdSvGn/GuY=;8quMx6Ufj0axn8KB0RL0aN9MLle
 wtgvvzc3cMUgD4PvIjaBe/9GFL7wqEhVWCuOkfR2LWKz5wNSb5UWbAsHZZMKPwNPvEIVX7mMX
 KlOSbr9/Tb6wBp3V0LhG2T3AAQu+fcWT4u4Am4YlV5akHUQnIx3bhuFiwr7Fz6jNWX2L0JJ2d
 p479bzxxVHUrr/Z/YokSW93SWhWnlfBxdDpyz5++ApTvywmRV+EO2+x+qq5hgYQeDy6f4jMbB
 75CZSstAdAdlkvwlgMP+UYNX5Xtn7G36KpelGjW67A4ejXyuXHdIXHukqkw2oWqumyb2vC8dM
 oJjGi+wZHxl0JBg/AZJg2I2pYyx+0WwzlUp1onD119hlmGw2BTZVp6yuKF9TyNK73+gBRyEuA
 FCCWzLw+4rfL9Xj+JV+eUHg1uP0RxEtj344jPgDh4wavXv7lOn38H6TGSTFaI+yR3oonQKk5+
 7VfyKtiwwhQjv03pNWx6i8dfRXS47CJycJHmNdE11AXNdVUaW9ZzwZDkRCFt8xNCe5OjNrDeF
 qQgbL8FCvD1Ro4C2eD9Z9o1DMwhl8N35wi/r+Fj7+QTP11HBbu4gkOMWLEa2ryAGBolqv73ay
 dA7gEaxb0dIlVpELTDvwtpeQ6B9bQpd86WDwyUhSAWKVW2UpIGunVrvG2fF/ChieuQrHAc69c
 DI4EXmDFg1DV3YA/slt50a079dqK6HQH7EI6IbAABz/dOmMc3VOu1vbMiIYMJPv5xMlTx7ps1
 tcqVqklzOo8SjIIZ9m869xrMhFUkNEQ530k2BKS0tFP3coU/+kcCQZnG2nFOg83uJVYB5xu3G
 +jUEse0bQHDE2rSfzEewooBvAX2MTYvg66cBBvhP/zEAw9r4r+pqyG3tIqt3Rf3VBvBmzQc1E
 eIOGzax5JkzbzyOPvwliqzmLfix9DEd3vAOajaVolQeG9inx4KJeo+l4LcQbAmpMc0uVuo3R4
 tyi3XcgRqUnMDUuBNfcrotK1X0+3C06EyHfrvhmsDXLsdc8MHapzmZ3ZsIGBvWkyLJ8JjuL2u
 2GTXF/zmVdm0NYYv2mOcVmaaW2Q6GJV+PiYHZBVCincDRDJU8YmB3tU6A5QFUJOEjZ7J0nScZ
 XaA6tGbm62fdf71dADnTPwjBc5U7dnc6KGCY0kbkBZnzKWAfRJKDJ3CcEA5g6NqryVHRi/K+Q
 cWca+4A0iYPtjWa5Qgn8Q4yTsdU7f6Szq5ORuRDmJfVsuJBR8/vXrjXrWWYN3d1ZXuNzf71CU
 dJdFyGjfw01JFrcbs+QWltUFDMuFz14qntfvhepXgt4cdyB7AW6QTUn8ivN29WyDXmPuAUq11
 rnGhqUobpmFbv8o1E+ObhXEKPHKogu6+PVNa9TxDuUw33K2piNmYRmvHz0KXlXdm8GIFsmF5N
 yeY/ajFsUnm4rZVOeI6kEnMnQdrPCzs9LAqB+8+lzFCb8wZL28ZZSEcjwTgYZbGlCdovZ2Bly
 bloB9FikkaKb3iMyNFt1026GN2Y9kLpWQ/1kjTZO1D6f24BOAxw/uhUE2AiJJKuPqTO+Da07m
 373EgNdc+40bzkRjjBcaQrYkQSLcM70CKgTUxSCeiII5PDp6Hdx25KB3DDsCrXhda8pHVX6oM
 dE8ETfVbVy5a0WPVWAw6Jb/pPrbXCo+j9/vZB4tJlaPYnG3PrjGAeZRAtcLubAELinuIF0kXa
 8ANhDgsATSksj1oB+xi57tlPI0wkv+ly1ZasW0GYIAI0C1RonzuVUmOBiIo4siTTWbHllZtjS
 eU4Czbqf/sEhmPfPijCZfBcFEoFdgJwQMS21Vshx5aKSBd7GbeEptm38cliNzxh4x7OZcxtk1
 viOxDsZNJhnEZ48jqdGYazvRuuPUTRtYVSZeJi4ajdLPX2dojwrY5YtEgYmYdXiB0X1j/WqhL
 AdDIIWUxLU45HgiZZ2s+CJCyTLSnhrSCh9moSwhaoCc1HJME7n60ysbczjwftReaKf6e0RgiI
 01m+BroB8AJw/u1Kpu/8WYERhSTQAY8oeq/iFMgwxn1v2wNJI2tpA3syX0xHHwES8E+5txUbq
 iN+62cXCgEe/BVEP3rNp1dRcn8CkBa9E0jzEY3OQf/POHxcxS162LUcChLA6FH3sXOHyqll+k
 UWzRci33jVfJs7DThjiePykqkoDBWkZ8beOg906K05ZGjHRfpOCDxamcMkH2CrRnDJMuOyHbS
 krgc2L2BBDqjs11r8OGJq5ts9kj6dyLBKdVbBVdP/qprMKB7tWNdcjIKWjcb7f+7qohZ2s2Xh
 bo4D03WE8kgAc6q9mtkzeNMJa4E64Bb1Nfu+RnWyNpxNgXko0R71s7/kLC/IGD/QwRlld/6co
 XmeFYcW6kU80JTmHIS7h2xYBNwLufBI5qG6yRk4IqQF9DU3m/7RQW0ecoO1OnQYe1I53bWNoV
 9AhrNnKA4OFg5Fq7wp6TnGL1j70cX5nQurMwND0QZ8fUf97KlT5jg3JGVAiuswk0ge2VluWwq
 44PYncCQqLf2Jvvu+g7z/XzvGmqPj06NbJyABvohvpLcozWxnKiitiOfk1iYIrEHZB8EQZwTa
 sMrAR+sEfpuCtqVMNKS/aIuLDxkb/HSZo5nvwwvF18N0LboNY+IumeY5qXSaypodNDsQ0K3r8
 O5FY+fbCDiiogTgiizqa44VXAOXDH/1QyXMlWUmABjwtURmII+hJ5c0TV/M1KIre4+EXP+rZ8
 F8txqC/UnIRTRqN/k6B7On/lnFz3lAMrHNawKFlbbEPvy18WFlVqyEnBIfQN0wtSyl9BeYM8W
 vNCOZI7TCwPC2d88kWuDSRTROc71zQimEcFnwwVA1HXtaM/OwaJqj2438rYqfzh0Lr+k/Irqi
 dW8BvmQd4D3CU9Z12dXb/NT2epzQue6GDo8SHZ4rBuVSZtmvtHUBxhXL9LPa56GiVZ3+ZnRb2
 eAqITHtRBlnMjMokRGQbhYEZgwH5kSfZ7eYhpxud3dgQFaK+nidQTJte0kjxFi9ACNt7dHhMc
 N6vag6X9Nsn9m1NijgCPdecNNxwljjVg/3niuoIneMi2zPexduo/7S/4CO6F8nXQF/NWzM1rj
 pCu6Sg7bl+8h57xjV3HIbtLxkZtWsas3fP4zYFD97XQYFgCeP7JdkU6/GARQeKc1ISFtFWBLZ
 nTVU19zeQhUx0vfac8fekNUOJ+VevkAPpeyibPvaABOkbp2bZCjrKnpcy//pu73+y2hQzRle0
 NWZDT7stO0Wf3gjgqneESxpIm762yprhhtDFpApaVvpwLUu8YxzJ9ae0E30EfN5P844pqTqxD
 n4X8xn4Lp3A2swUdB0LnhMQ595OGGQB8T+kJgAN6Zz5WK6pdxtSIXUtO0mPD7AswYS6rURihD
 bfVdOd/L1rUSEzPcoPnjrTtBJsYdYAIjuSjygJlzwrUxOYeoMqpGvkWoUnGW9+OJYd9ItKmgq
 a5VAcS+Bp3DrEMBHNIN38mygM8P2bkv7rzATCXFBCdzjpf1DbvmtBExLFmTxjQHT6KTZ/mjuI
 SyM6xgzYGEVsHTcSeUbq1n3NSipsdbU3CjhyWhrh2yampNsY2oTf/beobiwj6wnMZIZ815owG
 jkYhDmtmQmnDGqyvFGixMuFXw492YJy65pDG0tltVHhkC3dmfJd3uqpl9brpJg4hjHMWSSdqh
 wqP8/wTh00JaNXgsncfzSDyq0rF+xYL78BVuu2hhq/MThTTxEFILfFmwGw5W2iwDjj2G4FkDu
 QyH0gZzAQjfndr2p37xNV+xF4xn1uPn4Jztlp5SsQMEEuNzSZeWE3FQCMLpiv7XJY4Gbw9MOg
 ItDFcdoIpfJKyUR+yv+JthvSK7ofugN0h46TW/IPMOFYUm1kd2BAFTfWB6cO6DHLmWX12VkEv
 bOzY6vTn5w3xeZEJBwFUsUI6FMHzjSmE9AOJfIKVFrcW2fm3BK420rIg15iJUCngoDj4A1H8x
 OEbJcI14XLi9ZxTKLg9laci6LMt8jEPyK5hwwaXjqzTPs8nI8XuTGpgdvKFCnGI83D4UBsQi8
 Kc5kLdc7Qui5Ob8ArJlb1jR/p5DkxwoAlBQ6tuPPIW8wd0iP7id8aCqrlamGEUC8qoZcAuhWg
 1vqRic/oZ0p9crdXTbqtnKc5g0wzyzI6TbkpwKeNtVRxutSUj/vaWR+D8QRlUL6Dtz3kqD3Js
 fkJgXiQ2mx68HF3xfwDrRBo5eM/KHARaH1ZoK8xfTarnS702vCDiqyrV0ghB2peOJYjrbT+Dx
 AX8aEmxQN51iign2iyLqxOWKYCdrnLJ7Bw6Ob6hgeK0ieqyCRlsDZ6lhPOZQC6rFGCUnXt0Mf
 nygez7giXHS/WG8WTDsnNX8HeGgpr+zHZ+olbJiOZLd1mmAiNALj5rfQRkVDJ41aM832CbUSD
 Ln7kt7Wjri7BEseug7S2HSyyky8VxX/IIYam3k8DoGdERT1L7fBZo7qo6ZFoGpnL1pLCTucQ4
 K+3XPAe7PsD5Al+QHr5q/8jwH//hXc8hEmWRO3LZGlwM6jFImR/yGIkqbw9TxJi8EVAKyAcoz
 oHv+bcP5z6t30u90jhRSNt7xGNTjFub7wjo6knh1KN1MDFieLxbjsm0YdIDgHSPtW3hH949Kx
 s+c9vPp+tUudj97lN7hirkvwM5cdaDcLMew6Kg+/b61eeNfpULkeaxCLCmsRoAzfSvZxKF1Ag
 9+cEfvv1xIKGxijiLtegWh9EKgfTiJGEXOeUE38Wd5Xh0cg8CBuM0kQ6cLYXun71y/nba01D7
 HSepdnKL3r5JSc/AAHYGAa0tNbgl8FF+FdjNv4h1oZOAIbaWRiQPO/bQlF6zx8Ep4FD7sJvLW
 mqOxr1rKFbQzggGXo7rBJuJ0EB75L0JWkuhk2RXjGhBqQGINtL7iOfKKI8CHlLYyBrhlTTobC
 WPElz0925zNqSXoh8IEzSrJnXfThxYXM9nOnJiqEcoGK+5GFiOJdrZE778D3dPyNCOTtyx3lG
 FValRtQtvNgHEzkyyrsUAXdtJoVZNmcKPIy8q8DuMlbeI1oR9WpD1z4XNTuGhRmag0Z0upoLy
 RX6/JKfFX8LitdliGVD0Cb6hHkmK+aEhR2clR9AjgpI97VI2DpZOGWHadhoJ/zdGVKibH5/cE
 g3XYR9XAC4k1zTfmK5yZ/Jji/vx/e21Qv1Z0YKyGo/1kUbXjhEGumpEG/lDAUYGdzCt3DM0rX
 Sf3rB5FrrAU1J3nfPts31nVWFtCwsQr29WR6uwe9cDLr4ZF8AYaMnmZZ0Ka7vP+h8iO+orr04
 LaLnp0Q0HAG0sWeKp+Iln/EtqxmxuUUezlSDw6ZF5lQ++wjIQ2nLl9bfbAbMjU2tK9MysvJg=
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

I am ready to maintain it.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dccdf478886996d3a70f58b11c5dc55129122bba..60cdf6e8e2ef142266efa4b021=
9ff50f2b356852 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3848,6 +3848,7 @@ F: qapi/yank.json
=20
 COLO Framework
 M: Hailiang Zhang <zhanghailiang@xfusion.com>
+M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*
 F: include/migration/colo.h

=2D-=20
2.39.5



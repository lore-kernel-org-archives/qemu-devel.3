Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D55E6BF09
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnOh-0003O4-FA; Fri, 30 Jan 2026 07:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOd-0002W2-Aa
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:43 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOb-0001rj-4l
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769775274; x=1770380074; i=lukasstraub2@web.de;
 bh=qbSMswV8MTC3yxgwpbUETrfbVAYBdlQRbQVFKHPi2fs=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=NiwZpK/NR1BoOu1zDR2/bi5WJYO7MnI7EhJip0vO20daOXJA5OjeudeezAN5F/xB
 vw31S0n6hlbhMwpOPZft6fdSEN+VFaP/mvrsgVGtQV6S6CWXGfGtvcMv1ZDCle2o6
 Hc67R3mzZg4PPRwAk+FaiiBU2UGA8lEk9Hp5DfETw/d65PMH1KjjXfDQ7dBmZ/hi2
 DvAlJZ0oDvioIOgU1na9/4JZfRCbCnQh3SfO2ZW7UufmOKN9SBNV2Pl6oM0rxwETk
 HRuI2e+ItO4aNo8qzgYqmT6Mk+lOYeQLz3AwsBlzfFdVWFhBsOMUmpRscdtcfZvru
 6AgXIuR/NT4XlwXbiQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mpl0p-1w4d0R0CIn-00h5SH; Fri, 30
 Jan 2026 13:14:34 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 30 Jan 2026 13:14:10 +0100
Subject: [PATCH v4 02/16] MAINTAINERS: Remove Hailiang Zhang from COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260130-colo_unit_test_multifd-v4-2-7115ab6f0e77@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=GxECCZpyHzJgIqGcuRcKjiPYBnjH2GxZ/SlM89GQn1o=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpfKClPaMPydHiweiQtW8nUdeReF/L/zip3rnze
 +HwFpKLVwaJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXygpQAKCRA1qwsonF2y
 WBypD/0XsncVKG6gPzxvO5sS/yBdqmZoaFO9GI+w2X1BifN9rgbc6gbfr90l+eBo6+sfF4HQJX/
 byxhYVWfCCGKgw2Kp0tX5aciw5O1/L4AcvBraautyItK0TkIvnbTEUdYeJrPssHm30mtEtcO0Li
 tyTYDVvtBIKTdR0XGbR0Wk1bWjapG37x/h54aKFnpf+f6Fn+huUMyNXXrT8QdsneHg1AuYWZJH6
 Zi2C181SEtn6Nm9fyZdHqmlVxnsEAhWKtKG/apc5/5YzuB8ud3t5ET1hGeNKcVNA3tQBaNloWWz
 laatFW8K6mzaphC4BWt61j6AMukgC0iH1SfzCMHJ2j7uRmrulHy1nhECxvZKrSFeopXTzJBKWmX
 La3LPwF7H6E/xE/byhvv5aYfmU0CrdYMQiJu2XxhvbtyYpIRccsMZ23uJDiI9G8A0PjCS+PMYbh
 hF2Ihn910o9SIWu18wm3LtQOaue7nyQJg63ROxz5SLupKovmTKyTm3bOyyej7ApKRvBLuX9CV1G
 0pm0hnAK/rTSAiwsrUWzTPgfPBbyfq2Z7Zcu4FfmaksVU9oxMw7FjT0e2KsGgbnVnenltxrlalT
 lHroQjM7pDBxzp9+483BXsAZ48U1MMTgrZexgaVjrfBEdkFI7BcBPOKS/iQwT8LxGbD26f74gIU
 191OZuk149XSohQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:ezBJ8npEmbpKOqjJRYK7DHolyIA4JyxI5wmvYwMshTB6rpPM/KC
 Eu+miU2pqwPckIq4LCTmrp0KwWZdX5k3Vf4DG8uDDa/Fh0nQtmHWs7/y/gyfpsyx6Yltt4u
 kO8slqyPg/QbvF/Z06ydoSIQ9XCkOVULQcsB/IjLTe5R3/M7946NChuUHvwsVME615xMqZT
 Hnz/2U4muZpDE5PGgzVkQ==
UI-OutboundReport: notjunk:1;M01:P0:tS+W/DUy/cs=;0UMSKgy6are6yjpBqibzF1ivbYj
 sa3swo7kh+rWRdncN5JbobQVAcYg1i5nu/BU3BSDAc1OdU+KfCjPQKWgFy2J7WpJPEopd6g05
 2aPLgRIsLgw4iPsy0mDxxa2luAPWrwUN4A45+R62Meq7bVCwTSIrAyWH9bqBy6wpGes6Cjogv
 sjRWo94Uvoo3Qi1Q/GAIdyJUPcbaoUTnfE2f1b0xg1agalUPYB6X0Er/RvOCETH47j8IZZZxr
 cRdH2h9tmAsz7HC/WI42Pl2dW9eTIxklmol9EuNxcU/O+QL0X2k9JnOuPsPewKeviJM+hjH8l
 awjEI/5hf80WXCC1YhapWMZCJahyVO5UhecDDeSbMo6DLnoPUppwroRq+aITgFgiqw38qLvvn
 feHJ0qOtSaJQxH3+/GSDn4MeSe+hvwkUc4qwC7VwAPfhuplkfStrYiQ+GJD5SKTKVDpiGnmxP
 ds6jwahIdN9HizXzVDnM+4+k5IiElxAuOF6RrgSKk0cO0hqEvN6Kd0h5D3WhzqxcSHqgRZMRC
 ZTMScjVALC/9y0JLEIzG1Sa/+AqV8tqiSmVqV8Loqq/PayvSNknGYrVW1QfI92HK/h6XS8qQm
 MaYJS+0GJBTGFNRwWZ8nq5naoYAHYRzbYDNuN0K3ZUwjMx9yey4OzFZkWH0u3DtCYacPdf37L
 ZJ9g224jrUF2xX/ii6YvoKuj5v2pbSo+L5DJ2QRjmPuuU6GBI6BaP9l9DIFYGzm9Mq0Q36EbU
 a3U7SoqxjtyiZmNWmfROvvHWmkKBha3tlyoD3l3tyDIt2gO4hlqbOMMAFsvViTqRJAVDXkmKw
 T3gyLXEtiDQNv4BcWUngPzZuGj/D83nIaenFaLy9aaMLiWnuJvAe4WCryLEbjPdl6U9IpcYES
 SBYcngUK3igHOFoTFMEsbZa3PHTi8vA6JYGPX/n6eg1zIz6hmN5YwbVUgube3u5X6EOWxtuZT
 8IIGDWaeHO5qqDUzcMng/aTLGsuzc0qIpUfRfbtBcfwbIlLMyEDIfszCYhQuX7KAseWaGSC5v
 TksNd+JrHPzdx98IDehnIU4OWBzGhG3YvGKzr5iiFwrE/ZICQrz7WSh42t+f665v5pBxPkGCu
 JqvpOvaYKcNt35kqIaIgy8X+PBpT4IQjwm64KbqROQEyCRn3mlfE25v7f7jeyLixyz8FMWwpb
 NVpXwLVId7Zxgbe9Kwp8Agp/EvJdfwoOMD6nTXsQPSkjeCyhrdtKCu9sHIMOlsJFosJfRw83Q
 VJJbnZeALJzeAAS4Ivt+zwrtEi3x9epetPZsZYnVRSYrc5mzj3WNxd9Bb+JKLxO94FgU4cpzo
 nWWUECBmDX6JZ8bUA5gRHwlZW4z2hhBrwD8Y5sxiSI3lgmfwue1sHCqVG8fhaydpilWt3W6ou
 TvF8AuRLQeyoion5ZtcUlMPyyzKVNkH+17FzTAF3966dZNTc2vuztJbfTOU/31HQc6DpC9F3J
 6qzJ+sbXnALKdBniDQ9I9Uznq/aPLmrIPqRgY7sPiFRHYtKIytKvxegdpT9G8LKiChqK6OGX3
 fyK20Xj1OfwyNVwWKyX7e7y/F85xA5h7nWjsTG3pSUTEsv9p7hDzcfik1AvQ+EEiSIvix940o
 qznYn8U28AGmPGRvjGmuOXDfFjg70HT3ngt4oC4Jz0iFSgO8DiYza6Sc13fcyEar/MJSBcpjm
 rAfdLFQ0h+8J3syXC5sH2Fp9qjuNt8Ux52xebGm005Lv14bcSUTBL4LzsQu1L4LoKldeX/umT
 sv0V9J96tXD4lHc3cUbalxru2ELA8JtB4LnsDg5JRQHkhFz4ZnS/N8fujVBsBgMvEVrafavyj
 nfHVN2wpPF7sSUaGxqoFJNao0gpWBggiJE9lGgWEoPl9tLmHNo/8WuU0SJG+FxZLCEN1rbTyF
 OohXuKsVVvBrarsQ6nyehN0cr44Z2H91FOhMAOFBFXrfTUsZI5bXq4BuYCcDzMtYhS9ZsptCe
 ot5A/7sIq1zrGciqXePqL8vXjrxGUCjAFxV2B3Kq/mJcMCqlAuXImnrQ4egGSD8lstSEkjjYC
 mqP1cYhE+cuRVR38RDgcHDfABj+o7GXoY1gFM/WCipSAYmh6sCQZMYz9RynOH82HwoIVzfhcP
 En4KDzE3PIz7EQQcQ3tJ3FSPtEHQXwbWTq8RKa/Xv/g4tPCY/8XHSlb9JqKtqIQo4/d8yy4Fk
 cVZvpI4inD5tAPQK3OMwf5JYeSpwb0P40q+81ifBlFCikLoLxDG5YTTTA2xRcJFCPROwlnNix
 ogdOKqJGq0X9zhHCv/+9A2W+MbuZmfycJD8FivSn85RFp6QlDHMG9m+sfO8CtMYZh6WZEDwuA
 37sfTQkWW+MhYu7lhvfk+GoFytsUXM4tOStZcnxSLx8puqe92VQTFP2IE3Ej0weiz7EDvjbW0
 riAtad03ujjLMIKj1shq1kSg/SUrhPJUIPCZYIMVsNVLjWdfvSrf5p9qVV0DyRbr+UkrxMqC/
 2lk7naPyMNfYKPDqICwnGFqVxSVjzyQLqQvvQ3WRt+RU0QDbZiseUaIBvGyLwrBWerDhfYftV
 iAQ4qOXQR86kdWecisQ6hfogNU51+TjcDtePxFjCbXjOPu7MXyYaXB5Uo8kt9Objic+RuZowt
 d1QqEyc/S0iaLO33S4Cuq1Oty8n776/XuSJxgsH1mtBGBi69bmo8jad8A+bxFv4ZqH06yMXL8
 LkhUQc2YP0gFJnhfVWZ6ByN69qi4OYVSE+MDOFiV3vMagWoPGhsdQViAFB6zHGQIKS3nZ/4LB
 JYZ+SWLV59uJKBwLJgZfoniwDbtFVppmTdlKe6ivqG3NIwroK9Zt3Pl7t2CO2b7S7uk1Karrb
 EmupUmobTlHRPr6LONy+DJbtugyDgchqx19vg7kpfQDO7BodFcZZ2tRbuzfqPX08BirRzRRRT
 K0oVmYS6I6rmw2MdQj2ZxrWEv2C1sBjbB0qklf/OnIFJh0DVU+/GNWJD52lAqI+bY7R3w96nN
 wgoa1/FB0CSf2yTW5xz2HW0iEMV6EQnYHrhaTSSupCUaWnqdCHhFsQk2pqBJ7mLvi2ULzMLVJ
 binTuZaMcMAwH90zh/bTrSHde9uPDWoK/2yjepukCvOd6k6FkBUxR/m33kFFJc7z1povNQu/R
 P0DXdcT2orN3DD+Oan5aM9NraoryzD9iYwQ1eSY0smLElTfLhkcDbBB9cdDR6eKU4YuV20WFm
 y1WGr06AdNmRuajGK4Cw7kwhL8YrXqAkurEFGzYhU2aWjgEpUABhIzp9NUzDJjV0mnE2fhVZZ
 tPG0gnwt0W9bo80eBy4KL33eK2pKMIUiQnUVQAYQI8ueVKwjW+5qLZFql+vlA7C8eINbCMv3a
 9rjy37bSmhenogKqmWfOqRc1wufh6II4ZwEMTriAml0w/Qhfx5lVFquIXtIi7aIyK5FI69goD
 zY8bnXC+4KydNWFdRyi4IS/H2Mnb3zveuybNrtOkqRmvrfuohr2pdPaHkUB+/KKG+DOM/cEdy
 HqApKRL9+OytqxM/NW8moF6HtsCXXjKwAsaEBONXb/l7wDpsAkG07XE0wk0eMvnr+Icsji4sH
 2EdsQjQludcarwa4p/FlElwXG/IAFeVcVJGceiZ+MshI3qBhIDuzRy9SuEiqFG3myo6Wjx90q
 BNXAMPYs18kqYnYjSSAY9cEsEGAF8NZMYvKZodcpOpcTrZWVbErkD0fpG/IAK6nLshW9FA7G0
 SK+Sb3iEHkWVJKJULDNWV5vONMCERd7dYjYj1TCxrWeckdrqcLpwe/7ox8+6tKGzDMVA61erz
 aVext1uzBPqd3oOICuJ+olXS/QefBgCE8LylXxjdsA7r8ZEWPfPd1f0SyWcZsEmE5ICRtO1sk
 MubXvRzfSP8+rv22L6OuTAztbM3tz9k+ECJPbb9eJ3KJKpjguIQ05kzBri7YoEjsX3gtKOi2U
 k4ABY+hCWodzRTuxRHC7Jd5H+/kQCJZq5IVCX9TI946EJvw0/bqV7Z8mgIFRLqY2qEawr9N74
 ugDfNzjcaojt5cQoOIkEbWMwUyCMLTY740saUJHkLu8rHCwIzHKwqjYNN6vVf1rUUTwjzuWN0
 r1GMcgnkvME88oY41Hc5666I7cSf/5am85no1MRwY8EXXbVeESb7i9U4cLgGCzb/JRcX3fe36
 zGbh4A8q24G/ZxB1jMSDY/zPf7+CgAL809R2Wpl+D/Cv2bG97WNnjlVHaWXW7e/Mb+erJiNOO
 H4h3VyU/kq8l+1wjXzLGrj/a0md4rgP2h1i3umkNl7rJcQXzqb6lUEpSzrXstZynZMVySsiH/
 dfoVmXfATOTW0Var1chfgcUyYZkajFUO0jbK5NxYKMStPcQvDw4vZMdGx/UBAENvkGOg4r1AI
 tKUD6agnfENaf7SoMyWnyxat9Au0qpgcGyDkceL3oIwimvqScLEbnXCe4kd0aZ90qdHmJcb1n
 0Zkon/x9xCaRXG3q/Y9BdxRmZbXBVVvk0E3/Jqo1pU25y207WlpZWsaYRjdCAhPf8QaawOZW6
 mQzw7qN0KTfGMwmMrG0+9+iO0QONbK95g2TFY81bw/E4EoF5nJTNHKjj2t8INc7tcrpHYdm/Y
 iEx3G5YVRmPG58HfCT/Ugk6IY//DIHyQYnAOdGPJX2H+W64BVLQdKK0GiiYAU/n3hDxyCR7x5
 12Llp2Y9w+i+v6Imnx1INymvk6mCeOpLb6KG3laW8FJwWPqWKl+CImnKGIWsDBIAQKfJMOzd0
 Cjujt7iiCQhCL8eDfAPLa7yAJ3zM8LhGI9KajzH4N4JpzRSQq7/Hx69sZS/sjiwziHTwaSm/m
 UxbCSyChLrU+1HxdB0bD891mhZIaKSC3v3pPFs9vVq+3TxI0AREGuQjxOeXVpLa6tn23So8yG
 GQBfBi93ZDBHbd75c4qCG++IySybW48AwnDpbho9exsOBiIGR1LWMkSfCicnobQZqMkggoF/t
 TvQgdpxWsK8AQ/nCxGMWOokL4I0Al0q9Wa3JJCYeNRo2VZmE/X9W5aB5yCAJrTL+4PtX4qqNm
 762fKaKYPg5/gfibeXBzU1m/seKzmd51+t08UYZgcPWD7LpGkD1LRJFo4c+Ps+cUT/e0Dn6uY
 iZK5W7bRrNMILubvEwC3Q5qWnxCkl01u6dgWwpdW+wma/xajNEPJFuYgvIA0Gp0nnvreGe+kH
 bvpgC3CbQ0N3YORMH+A+HOr1VIjXx0xUVQ4miykwmdFh1LlMxYdjm35bh8O0fvPNqgWUf2X34
 TW+otPit6c52reV6qxaWakj3Y+YsxPCIuyHI84OH8lsoiwCBm0F+V+mXRbA04zWbnWd/Elfnk
 ueXK1YHl4edsDtCnjLjg
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

His last email to the mailing list is from December 2021:
https://lore.kernel.org/qemu-devel/20211214075424.6920-1-zhanghailiang@xfu=
sion.com/

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 60cdf6e8e2ef142266efa4b0219ff50f2b356852..b239cf00f66f0683d481150ba2=
7447316bcab72a 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3847,7 +3847,6 @@ F: include/qemu/yank.h
 F: qapi/yank.json
=20
 COLO Framework
-M: Hailiang Zhang <zhanghailiang@xfusion.com>
 M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*

=2D-=20
2.39.5



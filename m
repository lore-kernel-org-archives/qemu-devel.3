Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F70DE6ADC5
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 20:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXmi1-0000dG-5m; Mon, 22 Dec 2025 15:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXmht-0000WA-GA
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 15:40:43 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXmhr-0007iG-Of
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 15:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766436038; x=1767040838; i=deller@gmx.de;
 bh=EZRJsu1lXOmrSp/TDRxQ7ms1W0o1mOwdKL1Ebnac6GY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RYywgHblbMKd8TXAKimnCSlnUv1MOtJCJfdT8MEeRk7DD0y+EnUCyxmFSTFmW+rj
 +ZIQ6FgGJaoJgpCFBtzgxsQ+97/qIcIdLl9dUW0JlPOKW/HyH6PahqtrtvOYbkhy4
 2y/O+c3fIw57UNr4YWdNXxKZU9Iel5jUf2MtjO7Yt5ynTl/7J0237WuAzvcOhu+RZ
 NkaBkdN4/Ylj1kI4SifbhQz6gHn4lX5SqogUOjrkW/u/hMKrwaC+uE8WOX1EWdOYQ
 +n0ORK3fsVOQg25rzKcO0ZxuqqybbqNqJwTR/U21WIVCwP73QkqSFUt3iP2ulXo2N
 GalFKSNmDIEtu929ng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.229]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoNC-1vmc9w1fN8-00FWJj; Mon, 22
 Dec 2025 21:40:38 +0100
Message-ID: <bc7ceae5-ae51-42fb-b5a6-416f661a25d7@gmx.de>
Date: Mon, 22 Dec 2025 21:40:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] scsi:ncr710: Fix CTEST FIFO status
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 qemu-devel@nongnu.org, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
References: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
 <20251221142317.266293-11-soumyajyotisarkar23@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20251221142317.266293-11-soumyajyotisarkar23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/Lgb8h2wn0Ff3uOSZC3LTIhSOH/EIY6V9IVgZygdCH4+irtqjn5
 GVYGRR0QK1JQ2B5+ct12DMPPVagx8sXdmOmF0KeT3QLBfO65k5r8XuB/ht99eIwYUcGl8WP
 JEb9dAjk5haE3C4pX451d6NycLxJLBTCWXJaXoya+vFB5uogrcde1ujcM0F6Vq0jKEy7cBj
 FZ8MpySBuTERkTD9DOrOg==
UI-OutboundReport: notjunk:1;M01:P0:pLrrLZiopdE=;clh5Vu1pjL0H432sxjNjSqAhL86
 cNuxI4rB8l0fRxS4lsN+x0bRji/pe0SRRhgmGtV/Dg+STUGlCiJCK91tzW/sGvxgg2IcSMEAH
 Shpmhr37RgniNYhZZzTk+sz7gGiGLSvpmen4kTiyFrmj0qKi59Z8z3DoR+6REuDiSXno3dpEi
 qWe5MiztTfXlyzsO3SB4dd/bzAEWJohBcIC+ME1REA/m9hs1opJu5PjBUQcLMzwDIYi9UJd4F
 8j1yVBiDFYhnG9iN1MynHR+DlJTqglZr+rfaw5E6d19YRVvjdckznda1spzCPub1SC24gcghb
 I0oWvgJ/jb68Rnyqt3FhR2sJMBkapL7SZK1KVMUsbMen7WN96O5u8ft88/HBZ3OkCGMwNsC74
 p3aVYSho4BaJPnsEThoE+i0dxOkIHkvO+/MgnjHh//MdzHCzC7w6rvXy9fqAmph7ZH3tjfyFL
 Mpot3J5/VjELBDnhOlpwXptqAQUyGd2f0dcmyX9aZlEFpPNYYn3a+03zUG1hhETBULJsNkmFr
 A+0S336OrNcgST9EYFbjGxIXGCIK3jp4vPr3RyKDtUzZBg/DMPOPJ9NTL4ez2CHB15YW0wIO0
 yT/nSEMJS8FIWhSf9XbY02PKBgMRRj+nbomrKzwrtL2Zx01GVWkOp4GdFlomwaOwV8borfcYz
 ikPZQ1lzsCM5uzERb4CJs9vQNgEoOAckS2Wvp682tn4QLiAtr9xlzdCWu3NVp3vIbSMSuM/MP
 KPe+NTbWF5DluVgCGthVQc06b+ceJ3dC6yxpsn2L7kRZ2nv0OLAd1yCf+ZeUNtPZbDgdVcMFT
 x2ed/7FbscRqvnpIrehyZ5Vabhn6TNHqCvKa99VZqWX4XijwSCAn4p3IJhVO1vFYj7b0R49Hg
 Hl9WE6CbKlIPt3a0ZKJ4Cuhn62G+JfG0S1W4xIaAGTosEUnD3iwIG+ccD6S1ehl1Hi0WWEhMp
 aNmEP/e7gQ0mqxAOlnUvsNpjyIGDx4TSH22Y1QR8xK1GVivHZDjOxty4Ih/Jj7stKgQSeyx1q
 Sjm09+rLRwWjmJAkSR8CpoBYnXnyhNq51qe0CyUSJqJecC1q0sT8OGosyJN2UsiRjQBddSOcE
 Dha7YGBcKiOR3B1c+0nN7t6WQ04r1UTCc2CrIHzaIcIKPk5b9rPL/A1XUkubkD3teusvaGNwD
 HFmjAGyMOz8NGPfsN0dRz7Yeb1/3BAcKFFM+JqNbr7nPhEzZqKCu1V2M/+XfGqB416+4Mbn7p
 Ho5LGizNarxcQs6WklqaQapRWQ639pNSPEmzhdLq6cDX9K/9uHXaMsTEZoSv2pLbvLVjyMoGz
 jETfgGdXy6ku1gYM/3ebkAc1/E9Kak8LcJIlv9TOhPEMk9viYEluV+IyU4qpEBOR/RSRrn5cW
 hmFz8wXzbI7RZo6jJOCLQ8MQGnwtPH3bjLucRxg88uMLkW7bL6PsyDsHsbIZB5CSiMh1YzEPQ
 lSXeVE7jg7ZnxtqNpk0GZBsDfmSUs0EKiiF0vXhJ/NsIWIHzA+801GsP13NHNRnmLf2E+Aj67
 1S9NjONWAPSN7RtZr8ZUO2ZYNMzDO+lEVbFdznazw5EWS3aoHVxvhjRD00mkgKMA/otxDSMWJ
 M+WE3KLpqdNoUi5SgW0/rNbKVwCY+/ceGRuhgreeh7wHw59Ez4ulhYgUHXTOwwRNysm5Au6Y3
 kIZDeCpHqPRc0dFnrWX0k5WrDjw+XBSdJX0IaXERMQCbbh0HQYJ/BWDEaMHD8ErW0jx+DRROy
 9zvDPv5HUsLvweyecAZDiUdtuDr42Kt840QvmrJAoT4+r1Qz64zARy+Bh/iRzKavpJc4sj7a1
 i/RJaGBjk2e7sPxHQ8RZc8BrQ7nTw6+rH01580x+kibzkUL8TTbjCGfAbNJymDhFSEUHB0e+d
 mjh+JOtHmuB72d/wI9A8UINq9xPeuWOemkZ2k0xyM3Njqi2Iovf4Etlwhgl82uvrGK3ij9gcD
 3WzPJIMquZ7SddpUDWbRr/lIsC46gxTK2alBN4wtlsDdqpeW0sByyX9ZZmQWnJ2szSW9ID0la
 NWzAH6Qrw4SCa2mEN4YBufe70bhgxnuS7VgLqiIwbQY9sHQpij6/zHAPJTjl3YsrO9AoXPBZs
 cs6UcFIb/os52PPIbnl43Yc3l7SaFWcjFuXMvcHn5JElwZARQeWOOfYAnGn2TivIwbXtbweU1
 iQrE0Zvgp+qEJpjvCo7pXBuWNfe9HnWPuTYBTNRh2/uNQckFH44CSda5gLTTrp8/i8SSMfnZq
 t4pXQTkxGfX9UNijouPamYF+InX/I2A300tADf7AZOFS+Ekl26/UeJEQ1YWnB/AfMg40xBlep
 FNiSAAiyLBCHs8ncSV5su3g/Ecdrs/GGq2I0NbU59YKcLYaws8ACjLL/nv+WPokjh6krbSkVE
 CoFAg14acXiiCilyLtZzQO9eN8qAeGiN9f/jz7yxab89eqf1FBz92GuA3xbpOuilK7vFsy+kj
 rJCKhXmNBJodi5buhsAyL+BjR8GY0W8Rwm20+fmY5dSB4Xb93y1rASB3/DkRSWtxkEK7lHymi
 sEO+1oJpn67M36e+gtuhpBUVD0xTEclkwC9Ryt7jc/GC4jWPucfCwJMcqi4WiwYNkoVSNDqga
 HyrctgdWRkdJryYpC8xv001N+GT3/gQaMrvP1UoWZ0PVNShaJjIo6N9SKSxXzZTX2ng5i8poL
 5lfrRQ6SZ9gjm0LtahQlwyOsXL5fc8SGpUt40hxtlTprdqoDdjaI4qvMXZJNG3Sa06AmNl2CC
 7NwPf7LXdeGgCh4nK5tfw7bdmtrAOfyYVpxnLktzErbKWVh0/kYHmnCFzmP1J5I6QxCfrIyek
 J8zD0hq9bOF5RW46FITU9WVA/JEfmrXR3nwwjTYKX7GI09L2dgmkZSvvFsuWNv1Z3q1SRV+RW
 fqpWdU8sIEG6KpBdLFydOsfzctjCJ6K29Q6TEdR3LajVC0l/+t0PObQCjhdBfrqzzZFhv6wJ6
 WAFZdNVRCaiY4DOMfMmj24bazXta84Cz3xCTz/YOkdnxgDS4opRda6f0ae3n+G15mrbfNe8cG
 FaX+9e9tYFoxyHFD3qMmEl9iwj+mfrrUBZQrpCactUluw79GDR5WizZPZ09C6L3n4uFN+Eg0m
 WQSzaa/Zar05j9f9fLuc+dLfPVEYnxxcAdGrfwLgNBlhEvlq9YGZT89f5ARXNxMXq1loNeQ0n
 c1g9Ulv60n0hoV1GzeBD7wKfujsPnQQBzsmsjr67vseScPsBB75DAOnFFkRBNgcZ/czf+eO/0
 95zw0NQDe3cA+PSgNYSaIUhra7IiE9IAkg9YZas9yYBmWRfRkqx9KE+6LgR1ZY/n93RqG38M2
 KeEGZxd6b8qS+pBX3PkkMH6RXTmm6z4E92r1JJff23vyU3yd3E8VMIi1IhF5M8kWVfHrdxc1e
 BRvJk9VrDTsxXDEI/lVWKZOso1Fr7ggHJUdKTISUQN3Y93echHkfnaIkNkgwGl1E9C2QhDVV/
 aoKHu+SwXhcyALCrVx5btiFFGKXmpECT8BHxHaLB15qcYMsHndftUEODjcP/YoHECgV3KORYD
 JMJ7UOo5DN0qyTKEon4Mayf+Eg2QM/n9SGtAwWvwmyhl++6U2upn+LpqsmnaKFllXVURHDfZx
 CK/VVWl2sA7RAAlj1zekYyFknK2m4slf8/Z9BjhyVdpX9FYv0sST9Us328SeMeZfecwHvh0ws
 JHevAecFa4aiycDTMgpH7FHYg8MJ/Amh/kiz2XZ5Kla7BxxM4HUlDdpC98XttOws7nB+y4Bzf
 DWbUE68s81mhGhJJ1Ov9edkIAEkO0azJxOPpHSXZEJy20QrKzhvI11/BFUKi9Fv93trj+nec7
 IZGsh2ukeblmPzCeI1rjDMNUbvKPIVLrOrukEgE46NzS3HaR01iJMhYnumqtk8j8m6N58Eas+
 fsX4jW66rsNK1p/CSPVlWZqIXXg+DLyQlX25PnT6Sd940HoRlWGGzLSgYAC5S18Ol+0LU8kSW
 uIuxQav7eLVVdeobmlDISxcgVInQpdAYHF7xS3R/tQNBdhY8+c4csnnk+GY7HujQKr04V7Swe
 Vc7b9Xrg5uPfFY96+d9uSyAnLNVs5LZqtMpOlZtZvX88fJCaN8QjaMwrQI6r7Cw1iUXJI/3Qm
 08bSm6XgnKN9gocxe61HOkAxYBdYQHnADo2ngjQ+ig8xq3eGa32jLehSnzve0kgDdzdxLa9MU
 zh5hZF7sVwp1kGTAyd6lWMFEETtGyfjLnyaLqcty3wsmYtgMWIuhtK+RgmcE+xQ2K5c0l+V2a
 i0Sv7xIovc17sRq7+0zx8pPtUhziUJeT8BpA2V+P8LMRCW/l69/FnRdGu/q8rPKmFGo20sJ9X
 3cpiyPVhcKnsEy2rcLcnU8y7n9SXAYuloMkt+Mkxxym5dllTI2Q2RnrGcnqeFx2vXbUBZawlK
 kKs7+XaOuxJl2bY5QTsJ1wB32BMI4+t6+DhSy3E7R0uzkDRsHcjuG7cM8D5HHsiNeD2kUx3uS
 GjPedkW4MAOrKZHDQja9BGrAcNdAUw5TBOcvbZ2L5IzmwTfVKKWkqLppafDBc7ZCCzOmE5wB0
 VmqUDABtUKHg6JJvdaO+vSMNAxFveV1gr5Rcxq2sMxK9olhPLAb36XolC2R10ZPc3N7KLJcSC
 tADv7IZ7ne0p8aW1BX2r2ItgJtPylCnxAglvqi4cpmwSOyzMsSbEn+iiRA1fl3eFHLXlsjpe+
 K4bogu/dVV31HC2l32v46k2pCFDJF18XItPwXuhPBZocvPd19WdMNfaJm5svC2nyVUQBMqtVA
 Z/j3jNvL9bi5UYMC7sWSIQ0T5BQx8/nqikzeEAK1BmJAt5/mL+bHT53VsIoA1AMOr9Tego7hH
 J5um4zF280EcuIh8K2R46cNteJuaYkZQE8v85I761lUE3dUuNBXf4fXKa4cVLWqnEIjvp/ssU
 lsuFABmYbzvHVl5/JYNgh2up9zZ7xxSD4BnFWXZ8AMIrC/+l9ec8j7Exaqrb4k0yg1yFlGreU
 daueNYwndSl4M+QLN+nCRaaJsro7UvbU7c1ixw+Ibpe2VrTCQK+3tnIWemzSEpl55sTbq9XKF
 4bYo8fCHMfte4w2yTskfIOBi631MW/8PzKy/2E1rs/ReSbqwa1EjYsb7GgYt3c9pGOZpxvLer
 DpiKdnXbfXLvWvHDMjGTtZoTgattpjUv7izoHj
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/21/25 15:23, Soumyajyotii Ssarkar wrote:
> Update CTEST1 FIFO status when CTEST8 is written, setting to 0xFF when
> FIFO is flushed, otherwise clear to 0x00
>=20
> Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>

Tested-by: Helge Deller <deller@gmx.de>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C85C5516F
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 20:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqGmw-0006pC-JH; Sat, 01 Aug 2026 16:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wqGmu-0006ol-G8
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 16:58:32 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wqGms-0003fQ-IR
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 16:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785617907; x=1786222707; i=deller@gmx.de;
 bh=2OF0CYOvnDfItMeqKaULj6bQX40rmcRi6U/yl/Y9GC0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YdIAsQBgXiWKXI73q37s1mj1RHY/HKx+Bjcarjlzpz+NFZ8sB/lx7fV+PBvJDX2V
 f/ifpA6eS7+J20ZS81j8cN/lqO5FSYEKXIQY3wLNLCuw0ocDgS77pGdsnXgUEPSsa
 z052qeejeJPN8fcjj0mT6ioWgcgMDnd/gZM0f/NWQf+g+LjR8OXoSnBsZEGrdXnHN
 elLgKncCOYNUhJQRh4+8f0evQ4MI8Gn5MyY+MGOvu2EI2r1R+iU5jikElYDRSItxf
 PAKS3bIX6AltAvOrCg4k9i8XOe2Ycc9R3tSih7gZM6Mf7CAAjpl4V3Scb9RXHAmKM
 Vk5va6VDmOBQW22sew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPXdC-1wcR7o3P8M-00UgS7; Sat, 01
 Aug 2026 22:58:26 +0200
Message-ID: <a8c13cdc-54c3-4913-bc6e-956cbfe082cb@gmx.de>
Date: Sat, 1 Aug 2026 22:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix msqid_ds struct wrt 32-bit big endian
 architectures
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
References: <20260728192913.61279-1-deller@kernel.org>
 <CAFEAcA_8o2A8FDsJKacde+pdj4HzA5c7aTw=k7tmONYXD4=c_w@mail.gmail.com>
 <244987da-f6d8-47a8-ac4a-16a71c660e36@gmx.de>
 <CAFEAcA9F8rauUNc2NAqbnf1f7-0O_ivft1XOftwt1hW0YWeeJw@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAFEAcA9F8rauUNc2NAqbnf1f7-0O_ivft1XOftwt1hW0YWeeJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kc9WyzLdipYqoqnYWATIyPsEl8SrDXCGHsOSaFIR1clNHRMBuOZ
 tYzmyNKFVD7SfJrwi5tlyWpe3yzPNg+RwDUJxJZK/Zp3Mub6bt153x1WL/aJuP1jVffIaTM
 Zimo7DWs2H+wNJWhGeBh83cEFmItbCz6XgHPx2yLlW8Z3RJgTKfcTjb1SRXs+tEks5xi6WK
 dFZpZPLrtBzmWMoBHaMyA==
UI-OutboundReport: notjunk:1;M01:P0:1/IdmX/xPG4=;dgWVvcVFhRMEAmzWwVycXvM/SOX
 dQmFyxLhQbvmssnt73GlC8kcpnwCn5drWkllrKG8z4tIN29GnHIILhSTeT9K+QxNnqeBuTm+D
 TEqWlVRblx2LpdHWa1P3TGeLs+ErhH5yY5LYd6rcboNNmz7sZ5FGwD/+Q3VWrir0nwpwNl3/J
 CsWV2YLPsboHWLYWmBYRxlj2Tmu+BjdfESq/bbImahJlCi+fYLwcElz+G/OBmSxdYgm9eYL0W
 QUnu/GwjeCA6mnu0Do2+BUV/8jOD9r2dByDau+/CDruYZXiQPGFo0bog8W2+xl30b5msenwjF
 WTvTdWomXk5N34VuzMdnz92HMuZDzSPCanZpu4L7pKC/k+dLt3FQSoJiKObxgg10LsAP+jVQJ
 vYVTemetuqc91GvhX/nHhvIV5V/fcgHdFpu68ib09t1XspqrHz1wAmBML50l21cl7gh039XmE
 8M1nae5p0zbO822BChkkItibtnfYtrsIqYqfRoWpxtKS3mBZJEakFCFqqYRxn1ouqib7o7efd
 YfwLpMANkiiyuQX6jrryKH5HHEDDRxI3KCKSsrwZP73jd8OwarF7893YmfVD4Mkd3ffBU6cUH
 h/xHQIx+fwcRmDcySFoki1/oyFrAEsyZ9Z1D+y56TTAP8AH5r/xQcp+sJG6yllRtcgTZTTgnP
 xANDthxhHNNF3hHS1eXneGymEs7O9zZ0RjQpTBtiT70xYa2xmxGZKyvKpc6b9u5BMpjdcFbgB
 jHMG7xmuJmWLCG5//iZ/00fbsSp2OghofqjIWHBGU2gBUDvQHzhtt53n6lPrPQ1f9OME4wYBm
 vu0XVRBZV2Iu8teBhosfaSnYPX5ZFGLa2Z6h/0X0HNAq4sHZpRvwtHrrbT+4TaqZdobEt3XTo
 3LsjxFt6Tea5tAkvPSohC17a2pGDXKoRBGneB+TkvK+cV3up6v5lj2WUlqghSmxwu8k/VNQ1I
 dZDUtcBLePAoluG6uCs7PSxREW3wRh7agOZmPCjjpyoqzbzHUfel3vZqoX3ZLP0U+VjN7P35n
 vszZkZ4GCi7bx5n3ywYSrSH+WimPiBrtPy5XsfHxCk5xnN5ns/J/h+YwkaoGs3t/qu0qGif7O
 CiRS9JO+FJGRbV+bNWXgYvoGe2o0hVSVibx8BAnf8o28i9szU3dUODI5Ypz0Y/9S3oxlbcDsg
 lTkN5nEbQbcPdggQp75flQJMRvS1LQ/A8gLqOH/Wa5pu2+MbqlKCgmMSP2aeIrXXanJsE0Zyc
 WbAppVcNeA1XEdU9qj4xp4qdXruAiPNM5XNkaZ57V1fpK7Vm40wVoYCaVQnEWCmjuyulyMclM
 7lQ9YqBB+yLNxMesOwI7ivF1WJVw3RWc74wNI41XFnxSb5k5HgtTkJJPn2pPilptivoRgdPRe
 tzdZRlc8qZtbICO5CgYEv4pCPHFXkoNlPQcw87upkDjImqcnNRFA1cDWeRGf7nKYmai3ac0wT
 snkyCje6ceoAqZ8xUr12G3px7lsN8d87Mndsm+dV7PF6YjY5/qmi05uhs16tkkqDear9sriEx
 Gs8M/3/o6HhmU+3vS7N+0Ll8Wd5osH87hAieAXmebg2j0zNdPJ5AVjUApPudjvQjVNWvmbErQ
 fiogfnRfWTcK7VYZHQlKNo3x2Iyqt1F3YoGR5Euri0MxfgzpWYculF4AeZrvPBCRJxTbWpP+L
 HHiSBnfIXryueVZkW9H3le5chLWpT2E404STh4A5iVHyGmd7QuQAZxu4zpmtH6fXlya9VtvXy
 No4LedYu/+GTetGphTaRUTthY+StIWtf49ieHLP1wtccIvKSr46cGjK2EDnEVFa2JjHB50NdH
 4mk+eQDfiNAp1ge104EJZgDFMNWNyy8uKNMvgKs5yeLGQI0v31oxz49uZNXXC9JuSuXs6wetQ
 q3RxpZC6lFNb69KvfHRyPP6Ch/UkiPhvMn42BRR5lPnfmLnDmNWXKEfclpqf/5OVe6NJkTnYt
 e6gYh7vOfzarZfhmdFlHzt6BCDAWyuS9nuJ9eBaRno/AK1eaH+ZopZhHs9x71ykEULTciHs6J
 m1XPoDbMDI0bJNGiclcS1Lb+l0Du3/OKyoNnnVp0kxCTOL+soyyhOpwd0S3RJxb4mudWWREsH
 +qdnOBV0p0sN/QPQEmqpsfAYMuY1HjCh5tzAlsT8vsdiUfKDnvvC9HbIZg027gTVxplGoN+xu
 BB6HBiv8bA/QFr7pdaUHCdDHle+FrQyJ44dWuKSS/QpAs+alTJOBlF1LfZhwRQgKcp0wIkVYr
 b9qWWdAKhHE9kYAAKcK36gaXCKA5vINv+Ez+0E02P4dQAceS38cNreRbrSs6KkUtdbcoEQ4zQ
 SXCpkYyxZL3emlKTa+9bh8rh1qY7631RfS7N93Lkhe3uUhtppN+lR/enff7hqBn/ClKe2y4tD
 Q55hARwWKGChoATfaLkxOcRTMO8Zv1sCquUbLx1PYNtI07mxMQcp4FAS4KBNokOiuO6qpDLmv
 GCoYtGBdc+5Oh6ztpBFSQzrl+4dbg7wQ4YHjFB6+fUqwPVoFJdoP/Na3HeHXX2WrE7bg/BiE+
 kcAXzFUIvdWJJS0VLM/b0OouN1kPJ8rWrI5yUaFcaQBveQzbsNuKN0idhyt5TWKEEobz2NDGx
 c7fsie/FLuKvyPhZS5lxEt+0nBseewR/45YksN9rlj9dn0+1O/xIST7UbgcVcnOknYUJVQsKH
 A9OTM76KOoSB1fpMuX4eA1q9sF0OGHlX6jSLQkcgXczrFw3vfN3KeGW8K4e306unHEVAG94yo
 pX5qe0zyj5Gc+j45U2yCPfthM1AIkT8Ey/rZl5GZxkormebsDkEF8+gIvYp525S8R0xo4M11p
 gVetJ7AvAQKqWe2OF0hE06pW2EQSjPdQSH+2ZcQ4R+DxXejKy5FIUmXWaR8SKVMiahEncPMcC
 KCI8AKWaySWKjWKBsan7p1o5HPYyAa3Mf4eBMADSH6yFZ8Akq/VXbg3alWu5o3iwMIpIF5r5k
 7r930Ez+hygJ6YCst3i83ZbJSzmTWcE/gu+dQShUEJq0qujc8Ebnmyt1rV6RXpvJ6IwyaTEOo
 qk8qo6r0B5SwL90URcRdJ11hJpTsb08WnzqYwZ/uso9Yl/5Tw7jMJO2oyVI1EzEdRLMkEKTD4
 35glVPNRvVazI6cwCXj2c1y3NCH92FINow3GGlux6Sk57vozHgnwbx/2dWgkEcXMhtvsgX9H5
 2BwB7WlX9Oq6cZ8rnahDWUTJAmgNKOgJPND8UFAafmKIia6wqFCTJxkIE3v+sL8WDB9r2zrY/
 5I1JQimeKub0oarWMYrJS3q3IO+H8NvqzRg/NGKvbEkE87w0EwBgeI+1pYDDMrQE+ddckT0bW
 hOZCv02Q2IOPGwDsXsa5xg6Gua0Zp3txtn0hhGgkXFaI0C0YmN+fOiTcBEtmDssXxYU9qEeUx
 R8eblE+i/Cyb6VKXsGdk1zWxUOy74kDpAvCcYtPKCbRAzW6YaqKthAqCpP+LzToglAkEbNTh8
 8h5R4SY0jOm6RIMewXR6V0lYjNmhDqaUQVt+A7XHBH8mw57NJdwuSNjRNqe35Z5LQM0q3swxJ
 tp5k1r5A5kc/T8xd2WhRXV/0AalVE6PVlwb87InoWikjjxwyA9ORxCUZ8HgLYo+a8hWb32+Vy
 oJQJq2onx6v5VccvdYQp+Q4F1w2q6Ue+ZbGgPzrFIkwhTKjGTT/JXQ9V7V+COdF2i/02C+4/g
 m0aOTVrgNWcuQRo+lvjLpGRTQAOTbncbtXMaoPvFPAugQR1H/dmetDm7g67tQfPUtecl0SjZY
 Dwh0RiVI0BhhOzV8sXNvXZEdRee4iw4KkmNE1iXBmvG7pMC1S1bF4C09z3U1M/v/VfsZCau/m
 0CftYvWN6HMyX0r77lDBcEcj3PGVN7MwwrJuDVuzoYwY/JSzxrs5UKnUniZ3EdW9psqk3dAFa
 zAYsKbY75/JKF7ZDF7zMpjUL6SzpTXdeQmVUXpJgEk+opfm5rovR5zM5e3E8EultglIsEAUaC
 NcPanWSWBEIZG4I0LAWjGKD7WE751Y3ELtVeL94jQDmEeY8mCzE0rclIlIzVvU4qMjmD3FCat
 Vy5iUw1iLQgkQgbog2m2H9irjoHxJ0eike/51aFpt1ByJlBw4gZjTcZE1X5ETcrAmaYha4BWw
 wPitBs8pnWCTHrxVFkiHY51oaoaJHnGnnNv//s51sXt+aHoI1CLRhcILJXitsfn6Th8E1k4sJ
 VwU2MAvfRLvFg/sX4eRGOGlp1HojnpJHsc4Mah9Yuc7lVhqA0OnTXOw2AgK6Hj7U23v5adiCu
 SZ/qaBiayo0wiFwnIZzkl+zPrtrbmNtDXPy+C/zTlE1WhvrqiXp+psovWuJ0GzlqTRy4vlfi3
 nvM5FK8zTCgD5wR4nS9zVkLEtnV21/7H5kEjyWUN3QZgnlyTiUyRi+f6N7T/6DJeuDFfnpDot
 uodf5M9qzM1GUG8EJ40QwyRj0qQF54Bp3vPTWVt/y9/0fw53OHOIxdxeqC0J/XCqBTniX54X4
 nHpbBx0Y9eM/Dp3Y0YpmrnJsivS8sYqwmYTZaIFL1t13CYxH4zREBxaYQn7niJ+5h9teyjZjc
 dlJgoG3+rkCXaCeWmLQGFyx6YoI+FDbAEbHxWT7tvw/LrvAFHa1iXKFehaMa0uSsuC/b3JA8R
 tMBU+D2YwLcPg4OEvpRYRR5NQR0PyvI4MDQEfWCu/wGZEBUi8ZdHA00dPzDgjq0xkrUqRUv/B
 tO2zKWJpDy2Ma30sFkFFmzcpC+lTE3j4YsVbanHvHArqHj751XtaWCxhc7vNVVyY2LOla6zpV
 01SldLYsnAT6G923nyAcS6yVH4edAihuG+9jw+8usfLBNQgKYjkJOpbDyDiWwWj5Z4rgUQsnw
 SYeX0BfPczyJAmpNaP7onD8ErUj57IXwjTTwDbRvwRcP0HMZrl7Fr//05tdl8FRzo9rr/N4OK
 eUohuChsfPs3e4MrnykO5DA8yGdJGVfdS/IYK75wTEsiQxa4xZRY5DnIzY813xtOb7uCFKFsD
 RjychYB+H8zh+g0ftIMiND8A3OtYzSY47YoRUtQp42Pu0+T6Na2qhuNhOj+OyU7xyULCWQMen
 mIc9khLG8fPbtX1dX3E6pXy8nGiQfutLbHXmneO3AS4F1mR4W1o1aBJrOd9oQxgb7sc3uJWDl
 6TOo4wSAHMMGy5VaVL9J//XP+8zOjGYJdpcrxhY9ag7pWbbSNkRNTKHe9nIse8DjOfY2TxTLB
 5mnYgPE6LNRU4NknkMaTjXKwboTYrCr1QfjjeJY4kEbGXg9ylcm9j2EZSTW9nrqBVwNRnpZZR
 MULiemIk0dI2E2niy92huvef0kl+109yGK3zO0e705gyV1r3BE4aguFWtLnqEbA/uDVqYiAmx
 D0ZLXdXycFcX8FYtAvra3NjBS0x/uwRLXpaHzuUISyP14pOsuxT3pxp/0Y1Bk5ZzCP2inMiy2
 VpDS4ZF/8BwWyTWbPP1FZKNmffmB2WPXDGuYlWa0VPEmxsJh9w5K8ciop8OhvbAuzlshuhu57
 1VxAnn4kwefBcB/UWGjBgWJeGsSUii4Qu2EuK8EPqEypABhXxrca8WNREgpNWjNcUtLX+S+QE
 C6UgjLm+g0y+QCcInTiFXMUPCl2lu9649kPTXO1jqOPJrfU65WeSFdLPsOxl7unQHlfRoBOYY
 52Jzg+uvsm1pGpXFZflaemcuPJPRZJzK2f2wA6OzXWTPJrzDORfLBAQLnpYviKaj4bOs4gYSU
 CmFYorpFriIigIVfOeedVX4XIQtekFpMo8ikJry7Y70PluQB/Gqru3RIjc1PT61cLLYtdzHz6
 EPDj5gqFk31EVAMRKgSZyhxX6fZW4Z+hQ5iutt/5a+sI7aEv05uWCGI3ONoxZVNCEPZz9jN1H
 aSwmPDeaEqn3uPAekNsT+eG4bVvAL9IMpLXM2VlSav226plIOoeh845ElPV+cIXZXJri1Q4pP
 vBksFNznSK0EI7QEloaUhEFpOF6kRbyY+wSK4u1o1FYoQkN7zF2bixNDjo2KWA0LbrOujbO5p
 lXmQuAKc7c2wK0Pfckos9D4A3Q3OewTslNPhDjnWJl7p/b/GFy3FXk4ZQfIUq+upRFLhgunHM
 cbalCLFmkt37cMGNGjkH3B0OUMTteO2DaEmJQUAxHTh3C+1P7mM6jZ97hJ1yOKdU/phWXKQ==
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/1/26 14:11, Peter Maydell wrote:
> On Fri, 31 Jul 2026 at 20:36, Helge Deller <deller@gmx.de> wrote:
>>
>> Hello Peter,
>>
>> On 7/31/26 20:05, Peter Maydell wrote:
>>> On Tue, 28 Jul 2026 at 20:32, Helge Deller <deller@kernel.org> wrote:
>>>>
>>>> From: Helge Deller <deller@gmx.de>
>>>>
>>>> Make sure that the time entries (msg_stime, msg_rtime and msg_ctime)
>>>> are defined as 64-bit time_t values, since the userspace may access
>>>> the whole 64-bit value. By this change we fix the word ordering for
>>>> 32-bit big endian architectures as well.
>>>>
>>>> This fixes the msgctl01 LTP testcase on hppa32.
>>>>
>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>> ---
>>>>    linux-user/syscall.c | 30 ++++++++++++------------------
>>>>    1 file changed, 12 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>>> index 740142825d..c93b770ced 100644
>>>> --- a/linux-user/syscall.c
>>>> +++ b/linux-user/syscall.c
>>>> @@ -4216,21 +4216,15 @@ static inline abi_long do_semtimedop(int semi=
d,
>>>>    }
>>>>    #endif
>>>
>>> I see this has already gone into git, but some late review
>>> comments. I suspect this is mostly me being confused rather
>>> than actual problems.
>>>
>>>>
>>>> +#define target_time64_t         abi_ullong
>>>> +#define target_swap_time64(x)   tswap64(x)
>>>> +
>>>>    struct target_msqid_ds
>>>
>>> Is this the kernel's "struct msqid_ds" (which it calls "Obsolete, used
>>> only for backwards compatibility and libc5 compiles") or its msqid64_d=
s?
>>
>> Yes, it's msqid64_ds.
>>
>>> The layout matches msqid64_ds, which makes our struct a bit
>>> confusingly named.
>>
>> True.
>> In a follow-up patch this better should be renamed to target_msqid64_ds=
.
>>
>>>>    {
>>>>        struct target_ipc_perm msg_perm;
>>>> -    abi_ulong msg_stime;
>>>> -#if TARGET_ABI_BITS =3D=3D 32
>>>> -    abi_ulong __unused1;
>>>> -#endif
>>>> -    abi_ulong msg_rtime;
>>>> -#if TARGET_ABI_BITS =3D=3D 32
>>>> -    abi_ulong __unused2;
>>>> -#endif
>>>> -    abi_ulong msg_ctime;
>>>> -#if TARGET_ABI_BITS =3D=3D 32
>>>> -    abi_ulong __unused3;
>>>> -#endif
>>>> +    target_time64_t msg_stime;
>>>> +    target_time64_t msg_rtime;
>>>> +    target_time64_t msg_ctime;
>>>
>>> Assuming msqid64_ds, the kernel version of this struct has a comment:
>>>    * 64 bit architectures use a 64-bit long time field here, while
>>>    * 32 bit architectures have a pair of unsigned long values.
>>>    * On big-endian systems, the lower half is in the wrong place.
>>
>> Those comments are from the generic header:
>> include/uapi/asm-generic/msgbuf.h
>> and I think the last sentence about big-endian systems is wrong, as
>> most platforms provide an own architecture-specific header file, e.g:
>> arch/xtensa/include/uapi/asm/msgbuf.h
>> and the big-endian platforms seem to have their high-word first.
>=20
> The comment is correct for any bigendian 32-bit system that
> uses the kernel's asm-generic structure. Maybe there just aren't
> any of those that we care about?

m68k could be a problem.
The other big-arches seem to be handled correctly by the kernel:
arch/sparc/include/uapi/asm/msgbuf.h:struct msqid64_ds {
arch/parisc/include/uapi/asm/msgbuf.h:struct msqid64_ds {
arch/xtensa/include/uapi/asm/msgbuf.h:struct msqid64_ds {
arch/x86/include/uapi/asm/msgbuf.h:struct msqid64_ds {
arch/powerpc/include/uapi/asm/msgbuf.h:struct msqid64_ds {
arch/mips/include/uapi/asm/msgbuf.h:struct msqid64_ds {
arch/mips/include/uapi/asm/msgbuf.h:struct msqid64_ds {
arch/mips/include/uapi/asm/msgbuf.h:struct msqid64_ds {
 =20
>>> That would make tswap64() not the right swap for 32-bit big
>>> endian guests.
>>
>> I did my testing on the 32-bit hppa/parisc platform, and with my patch
>> the results in qemu were correct and were the same as on physical machi=
nes.
>>
>> I just tried in a 32-bit powerpc chroot and the msgctl01 now succeeds t=
here as well.
>> So, I think my patch is generally ok.
>=20
> Yeah, 32-bit powerpc also provides its own structure definition.
>=20
> I think it's worth having a comment about this, at least, because
> otherwise the obvious assumption is that our struct which has
> no target-specific ifdefs is supposed to match the kernel's
> asm-generic struct.

Yes, I will the testing on m68k, afterwards I can come up with a proposal.
Maybe it makes sense to modify the kernel comment too....

> We could alternatively follow the kernel more closely in having our
> generic struct match the kernel's and then having the archs which
> have custom versions override that, but that would be a bunch of
> extra work to get to the same place in the end.
Let me do the testing on m68k. If the tests fail with the current code,
we need to add custom versions anyway.

Helge


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD969EA811F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpohl-0005El-QS; Tue, 10 Feb 2026 09:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohd-00059D-HK
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:58 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohb-0005m1-Ix
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770733602; x=1771338402; i=lukasstraub2@web.de;
 bh=7na/cU/5mF9ehdTeY4EL5tJl/nkO7neQy2zDMuNSRZI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=s/X/4EJRyqeRHFaJLhlw9x2L5DTadOJdon+ibSmBFfuAuiMF9nlTmY2sjOaqz9CB
 iuHq2PIzByBNnS+cYO6lMja6eRabB3aGo7S5UNxwWO+OMsJbW8j2L6cIfuW9taQNf
 MjNaJNtLY59Gehcoe8lw/XAekrzHfsLKJWt/9MKjmRvdVGlZqjDwrCgJly7NUIOW1
 k6sVwp+fspfgny4HJgXCawtNsCvLX1AAhfC4cR+ANo9C+BPDTjUKG3vjTZ2UdCXMK
 DM27iO098wqBVFhv+b3oZAwB8yMp+GX1eVWBCKiTc4+Llspy7mTI3nc9WLYzwIAqg
 4BN4Flroy2H2gGi1tw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9ISh-1vuW4D2MWF-00GSwj; Tue, 10
 Feb 2026 15:26:42 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 15:26:28 +0100
Subject: [PATCH v7 16/18] qemu-colo.rst: Miscellaneous changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v7-16-23bd32f36828@web.de>
References: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3240; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=xf4Mr+LNhtrRhluncnlq21hBJuEc0CRkqsQ5PC6uWik=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi0Ac5qrxT05DXNU7MGhnWKdIuSNoLGRTGeSIV
 neP9Cb1oqKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtAHAAKCRA1qwsonF2y
 WOP2EACqktFa8YorZ8XKRrpeO5GHTAuYyyzAg+Y9e2misyu/2Ew/d4Ws/772/Pum9/dxzVs7k5i
 Nx0BK0d62n7jWX+SPcNHP0HxVirSUI5ZaZK3oRPTzoM1hO70BgkJasW2oO4SFS2mY7o/npVT41g
 QAE/7pKkxpGPGRIknmBTtJae2WyeXAr6wmaYDdjcOSxgwoRu5zQVspcaGhAa8WnxwdhIm7hwONM
 b48HfBAbMsU3UXMb7pB/iUjVqf0CPQFPIeWsfMtBZmoLVC7qk2XKjeyFHO3InMzRnFC8u40HrDU
 Js9y1BxlWnME8IhFUVOv8MdZLQh8x/CYr/2mwNjBqxOKYpITC8ibZRhx4paLTpr2fYZNdyjZPlL
 QUic/8lualVfcGcX3AjJQNkwqrC8XUDtPnoyVAdbUOTZRsdmOhI0pP0/DM00K+oXb4sskOBGcs1
 07TI4C7YtM0nUbLJWO1lFtUO3df3XiRK6TLgqbjVcpA7JMX8SoxCDefOvZuYklJNDSYVLtXgPQ8
 NjvqtP0o+08GgaXzvnhH/vte0a8tONAsqHPXGB/G3x2amrDIeGVi0FGkyrh8VUSNXNrVl7QnCL3
 5TGp28NZN2r/V8roOXhFE9XMIiNQsVx35qcvF8xqNXszGVJAbZv4S3Xwt7XwtVG4QlyMSgkM9qP
 67kLf8AX3+k1zhg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:k/j0e1W6SVMY5CELx88SNBkXZRCXvLXm2kPqtnyf8FARuK6EteX
 l9p9XXJSTD1Aggp7nteSxh49pE8zJl4UGKszu4Wa0yIsf4b/qA7Yp67SkDQB1ecfFzrqtm+
 nfGAHOO93FD6gIomz5REFTYtUHxwDEATYqZu4Cf2i2yeO/qkgNRPlKaVv1S+HxyKQZVObbI
 5DhdqTVO0Eiu1KQtEV7nA==
UI-OutboundReport: notjunk:1;M01:P0:gWrMEUjPWhU=;guiTh3//bLhCRjOjPEtGqNsjHA+
 YcPD7fp51d/O+HOieTmag5a9tEbrQMkEiM7j343VtbMceuaowtr42GjQLv4z/3vgPk3c7xVSz
 e+rjLTQMo1Ylc9pjxOILRe1hHUpfbgZGBw/Q3OIXkonjJdfeRzN6DI+HgDI6mz0pRLYcFgxgt
 5DAQuunb/8f/PlZpJtq1to4uARjMnhVFA77h+Pnb+tVi2rq9d4ylKZMPoVJE1aFDTqyoGKJZY
 fHPaf6fQJMmGCU2aYbkwdRUdBf8DB4TiEQM301Jrt3g/D9P9xf0aIwVh51C3YOJO2jIVE8vYF
 i/3PNKBTxHrCwcflNcpOg1HqIHoOxRhREauFYBRqFeK7h22ztrYOLwDOj5lS2ur/wMLMx7Hv3
 aTxirnKDwjNqXq73BsSx8cIGzFnTRK7O21O4daWbLAVJw2yONubLVHD85/FdaaRtuNbblFT0h
 NGdOtaGIPHL1UEpFe0oER1KHaB/1Os3n32eDS3CPcdTpcs0GhIP9/XRjyKM0uZUckg3tgWRq4
 FqCILlrzfcMsfL+nvswpLhtVjFykXvoY4nSi0GMjyTGVHnJjxkTawK4e7GfpQcFnUd6OPNi3X
 dXwPL/zQEmdhlzARrq9mQ4ZoFYSHsJE8gf7NSBDliclmaWcg0VB6x2Bvc3gLfiEiqNDzA89ft
 ZZVA4mWU+RW6Jdw3en9M9ORPCN/0lWSrvaYFpn6yfQaWvxQ8AtCVKn4ewTi4Xxx3hC758IZ7/
 B6A9yBW0/8BaNdr2A0k6xu7hqzD2ysExekogYHiMb6Jy6nHns32z5k5xY2w78SSSfLirePDM2
 IzS8matV3etJihAkm5MMwxUDt4qTEi8L3p926AqX17MIQxYTnCD3s5aVTnu2LqrPv/2z/raO/
 wX96joZZZ6dxoLBt4dxLNVj9/3jqaRHBog8xTGRkyEgMeh+MSFm0TSVUKvJaRRQSZVTJKL5/a
 XSem5PlDCm+T8liwuaLaQBwNYmT3vzepXNQ8FU6zOL6CpNvzBIwBofW3tjbtIOTClo+J3rIVp
 2NBTqFU4sEaAzZ6F51BZ9l7XZYaqecRLz61DMidBAntVlK+IXgaC503phJRf9WM5k9rczKW/W
 L7sEP4LAKLMIbtZAmY8M7eaPEej+ss78IUoKmKoMU9ihbaeSaOc93ueRNeek5Sfa9wwu2syWG
 aZKpHRTtssQwJ4Tn9b4TnLeTuyN3i5LPY74zvCW//v+um0BW2CncIfFwclCzKwenrHq/+ZhUj
 CsWQiyfo/uJt2D/p6TB1XLMh3mNUe6wUlv8vkxSCfAETK5RorjRGVKZQIAb/dR/75Fuyn2BFR
 KQST0La2o9uy4ie8pT5PVFcB1I8ona89WcMXUt5OYSTQ04P7wMmrHMNNjc9jy3V/RXrr7+e6i
 hgWJ2COWxhkYk5NCgGZ7f60p0uzugm7fXMtUqZWRMmut0orjUClvUeOfwhY8XywTzGPuFXxx1
 sXvnZ2tPd6cMRY1+RwVi0TuWHe5E+0E8BUe9q+lnfGw6stJ52elKs+j/wM8WhwY+sRfPNPDrw
 j5s3RPzguXY9u7W1CmPdHxj+xvuzgvkazYY7P2yys/aK87X5XIXv2+7G9/zB0XKPBTQQ+LqGi
 dYib1P6erH7upzbUPoSGr0lUNFxLBks1CsixqVGJK8K5CmwV6XKQi8vEg6ivDVDk2IJ0KLKbl
 Q2Jv6jyQ/XID2GbRHLsxtA9qOxI+2Aeg++4Tv7aNv+gg4U1sriYqLBq8bJM99RxsQNsv6H/Hw
 YunVukyAt5YbVr1OBhMzEx4vq/UUGwGrqBGiBTujDg0QUMyKgHv8jYMOYgA3bARhMfMFaUxld
 VWAYmvjfaIY1v6PXZpMlgJ3gMXP2JQp1cpQ6HnWgjIlUEL3rB0uGLfYbgRnRASDNVb7vrsS4t
 gi0lX5HwSZRnYHux7Q6NULWhgwtXkwuziICcZRJK34uKK3SevV4vIC/kUReXx47hKN2knOAzd
 wV8pSRb3GrkldtwnmOWY1in+XIfbIep59LrGOZ9SeRf1dNfqsmBbeTyGzhJCe8R9dsms/bJfi
 0exDwBzi8VQAVT12AMV9Ua8TpSq54LpKV/pmOaRXMtnSog6OwuWEvcL9kpA4AF0oZEuRbHOrb
 7jw+Sry+FoW1nRIbKvL6QkKesb+jSXPK7qd7SMZgVCb4v4KGV2gj5v8bXb87pUoM4VIWea1WV
 LjPel9xuKBMwqJIq71VbLp9A98+TLupFiiKykLt30AysZnzrJ7CPCwGDXjZMuE486SVl/ru+4
 k3IpajujIGE362Y+Z1v8UNBr55PIl+QbUxWDfFqltX3tTj57G6beT9rcA2J6ntfoTG6vqq5Fy
 d3QRxdvEZpitq2TdrHGV3aP3fkPisen7IJvaM28ALsX5omgUOT+A4jV8Nxw5t75eK0J9bUzKG
 N258K6Odf2Kk3CDT58DQ+XQFpEPpjnJc70iJGXoWvMZ+Yg344X6PRgx39FcpdhPUMdazMUkSt
 zbxijqnhnLNs7+rjezmb6l/EcWlsAwBvr2Uxwtx0rgmQXNNO8VCHk9Kbww9zL21fuYfdcauwN
 qHpRDDkxtYU1RPY124cBHXMCWsMCRQIY2Jf8D1o44yWzGRMpx1H+MwkwrdCge6EO7Q5Ea03yg
 /8E8ifJwfWek9oXpabwzMUbeM1GDt0zYa5fLofkiTPuHzZnKlDvs8+nXGXloGjn2+vks9K0Vk
 RuLaUm1nmJ24zPPcsodDlR4QfgZq5Ymk5U25gjXlVTSElqKFj2EyL7qY4xeHcsodTPcVHG/1f
 Up96ldkyRt6hRlhIcbGdfDvEshU/Ns+TtR7jyxieS9H2PsbvXolIO8dCdsmK6Hr6hHnlvOybR
 OeiY2u7L91HsJSEI77IVKZiAVGcbSf+80+m4xYpQokCjJLChaE6qogylWuA3o9REWakFBe7Od
 qVpUzlEv8BCfYzqUqKRrxa7XL717b/j773BIQXD5FNckZN+deFaVVZYu1H7/YT1oZX2kUojiX
 A8q+B9AFeGljGMPuTenhLL6BYwFQiKEg6WGC3txBdkFADBUGObiStPpNjeo/3o95UMqoCAXkM
 2bsailIPZ+qCDaZF76Io1wpGDZUjcrqE1n/IFy5AV6QAkWdQr7q/Yc50weZqNy+ejq3P1Mkjd
 lb1f/nKPAaGK36OsLvUb/TusrbCazQi+BN815H3vWm8cQ7HXiQmCDBPScHBdQgL5+J9nPkLRQ
 pNYIKE5Jwlfr9OqND4gFNf662XuQBtgpC0TnnRSey1YdhUZy8rD32fAT9H/6Wkczilyt2lwOV
 4VxjE/gRHpRHSZKBoLgyVcKAsAQU+6x3A4rxcQ4Nau9/MHt7j1YlMnvK8ooIcRkbjQYc6maEU
 h0EbG27Do8vpnIuDp83F0ZxEFgPbJi1ke8tIpvnuBSaa8jX7Iwl4sPb1Ziuzh7mX6w59ZZGQB
 SgoZLEvAdOECTZmB0x4IZ5qnwQyKXQMkwbr3EanBXXUbtlPdbOXIpvMEuQ2vXBPoEDAcSVduR
 ySvz7ctNjvpoMxHrtA9UKr8nn8660eN2ejm0ffF1DMpFcUnp2UtAwV6IYYgWBUdki3iUuD6hR
 Lf8yeF0u7kMow3jGkmBbqZdiTaS37Rw2Z65msUuFrvIoVWcPwuDfvO3dzoh/4hiK72bb4fT95
 m3bs2sa7x4Ng/RFxpmpxuPbgC7G3bGllpFswMhjOSVjxO9ptCA9IyksvGSiMsz3ghNPZtDTvK
 rYa6BdwVtcVuVJAV9TIoAcmaGszmTf1oBn5rMfMVZ1tEcB8I2qPuvTvyouIbP2ygb6dGOqaSq
 jieo+lUo1c8t7gwd3x7yg0iE6tMyeA0yTVgYh+Sgdv69pUArxdztgdgcsL07fZrTyLgEVlm1c
 PrKDRN3n7ExJdECNilFfZaEtNUzKBhj4/ipcndHt2MQE8REc+CwzErTARK4O047Rqc94EgyUA
 6jh0viB7dWgBmjiGgckJO9I2sMcbyv59cEQXilJDAuYnKNAHiOL/Zw7HYGO/3IY+7QHlRZDKh
 9k2+9uIjauqlGg2jkdGWuzaHsSwviyeD9em6t/JOQQgGeFlSib1s6ddN+C0GwoXwjVy9MVXz0
 oss//8sWLbcIIsgBxC1gcTXpbPRyPjyzvk7ElgPp7VxP2WTMbL0Jiy3jnCvs1llzuTlan1zUi
 jOFzuDXIPQV26h8+rF/2mN0b165D8I2hO38Sbh4ACe4j6JbwSEL+uFuRoE13cz9hA/iagnIXv
 +51RMvBjsuJq7pNc0IUkxSwe/rArpmuDjbhcMiYMxK3+jOLUJ3guefNBjZLlFWV7eLUaZZLUo
 bNVLNRayV0iTD05VPOUKx7u/U628QStp/UljlX7NrTtg4U1Z3LJSTODTL0Eo45JsWS4fpIIGG
 +V/LsileZUiuuKOwuQQJBS8I/8ZHOWt0u1Hrdk4cP5gDlBgcwvVEEZRB4oGmwSW2Fwdr0/h5A
 iQcrstJrNdl3u4bk2gm3PEW3pzxt/AeuBhqEIkenqy7QmKceapO1w0GYMfgclb3tBBzyGkSMz
 +Y/sGyHWwAjv8YbQ38Z7+bD0XDf8g7z7qHdd9aaNdMNBgkw2oQ4QjL8I33iDWGtL5lhgpnx07
 /UmX1DMpgLsEWzeuoMjaOoBWvNqii3L26x19fYVfIZdYZUjb7EEQJ2D6yQ9ng3loqHlbK5R5I
 lqx2jouKLkHKDZqJRMH1CFf/WfcKnX0krkzJ3PMwpr3vvD2ZfiNOBqNZk/pNh6LFWBaETV8vo
 oOhZ6/a19Dqk/pyOYsx3HXV2zzihVmz46Jf5WLdLkXjPDltOX2+e8fQqi1YsdpjjwIVLfPoU4
 zP93IUqaZWJRAuHDZEDYIfWGV5JxUr8KsW2Y57hicErNBQ8ot54wumrBIMaz6eq8iwTcKnJ7K
 f+Az/hiMhO3FmhZ4qAa4V396c1dW6Bm5U6vVLTEF5kw+kAKDPLmOeqsIo4tpWFFNth8Iie2rn
 mdbZ9TSPdi74UZoU/qOPbXbEyQMIJ5B0LuzRsa0dM5rhlS2C/WGyOFWs5MezUa1+/aUQ55Nk9
 UAK7kKsgyOt/xufVw9cf5pjQE58PTlwFnmVBSroq/eZReooK+WfgUhgA4ErYCqZFxLQkVJo2G
 W6wc13kGTsWr647bqLQIeGQnMY6ffO4kbC2NHeXw66G4Jf0EMF5A6o88I2Q4/l4Rsvlf4fVcp
 DkAF3A+CIq+sr/F164OdhxD4U+8aWRCMS75Cljd98lwIfF6t1t9XMksZNPSsUcdI5BbnzCbom
 YTuE/mvn2VhOHeeOoBKWFSRSW2z/e
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 docs/system/qemu-colo.rst | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
index 4b5fbbf398f8a5c4ea6baad615bde94b2b4678d2..a70e61aa09391cda933031535f=
a982d27cf6654b 100644
=2D-- a/docs/system/qemu-colo.rst
+++ b/docs/system/qemu-colo.rst
@@ -1,13 +1,6 @@
 Qemu COLO Fault Tolerance
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
=20
-| Copyright (c) 2016 Intel Corporation
-| Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
-| Copyright (c) 2016 Fujitsu, Corp.
-
-This work is licensed under the terms of the GNU GPL, version 2 or later.
-See the COPYING file in the top-level directory.
-
 This document gives an overview of COLO's design and how to use it.
=20
 Background
@@ -82,8 +75,8 @@ Overview::
         |   Storage     |  |External Network|       | External Network | =
|   Storage    |
         +---------------+  +----------------+       +------------------+ =
+--------------+
=20
-Components introduction
-^^^^^^^^^^^^^^^^^^^^^^^
+Components
+^^^^^^^^^^
 You can see there are several components in COLO's diagram of architectur=
e.
 Their functions are described below.
=20
@@ -157,14 +150,21 @@ in test procedure.
=20
 Test procedure
 --------------
-Note: Here we are running both instances on the same host for testing,
+
+Setup
+^^^^^
+
+Here we are running both instances on the same host for testing,
 change the IP Addresses if you want to run it on two hosts. Initially
 ``127.0.0.1`` is the Primary Host and ``127.0.0.2`` is the Secondary Host=
.
=20
+COLO uses double the guest ram size on the secondary side. The Qemu versi=
on
+should be the same on both hosts.
+
 Startup qemu
 ^^^^^^^^^^^^
 **1. Primary**:
-Note: Initially, ``$imagefolder/primary.qcow2`` needs to be copied to all=
 hosts.
+Initially, ``$imagefolder/primary.qcow2`` needs to be copied to all hosts=
.
 You don't need to change any IP's here, because ``0.0.0.0`` listens on an=
y
 interface. The chardev's with ``127.0.0.1`` IP's loopback to the local qe=
mu
 instance::
@@ -192,7 +192,7 @@ instance::
=20
=20
 **2. Secondary**:
-Note: Active and hidden images need to be created only once and the
+Active and hidden images need to be created only once and the
 size should be the same as ``primary.qcow2``. Again, you don't need to ch=
ange
 any IP's here, except for the ``$primary_ip`` variable::
=20
@@ -353,8 +353,9 @@ Wait until disk is synced, then::
     {"execute": "migrate-set-capabilities", "arguments":{ "capabilities":=
 [ {"capability": "x-colo", "state": true } ] } }
     {"execute": "migrate", "arguments":{ "uri": "tcp:127.0.0.1:9998" } }
=20
-TODO
=2D----
-1. Support shared storage.
-2. Develop the heartbeat part.
-3. Reduce checkpoint VM=E2=80=99s downtime while doing checkpoint.
+| Copyright (c) 2016 Intel Corporation
+| Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
+| Copyright (c) 2016 Fujitsu, Corp.
+
+This work is licensed under the terms of the GNU GPL, version 2 or later.
+See the COPYING file in the top-level directory.

=2D-=20
2.39.5



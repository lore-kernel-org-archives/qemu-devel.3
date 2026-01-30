Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E35CE6BF08
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnOp-0004Xg-3h; Fri, 30 Jan 2026 07:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOk-0003vS-5D
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:50 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOi-0001vo-6j
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769775278; x=1770380078; i=lukasstraub2@web.de;
 bh=V2wl7+xKW2VUs5IlZ39gvgGSN6Swz3GT8YAOMgvY2Y0=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=eyU8ZQGTYEFCGfdATi2NyhUiL3Jo0CAt68sYfkDuuLdx0Qy0Z6cl0F0nrpwoVBny
 ExSuXs/09TXw+6oaFmR54yjBKORbyIqpgJA0GZttxzNsWsUIsPtGvsVIA4y1CyrxY
 ODR01J7KR5N8RGjI7Paz5gD7hLerPNldjaY+PKJGKqzeaK+j+Eyz1YRMc6poTsfPy
 6wBQOpqaHGMr/kDh0uZMWVUlE7sw2Dk0Z4x9hJ9DjQPJFYq1EVv5/j8H42FBe5nKf
 tFsOPv11ZpBR/tYs8DijL+9PZsxJHLijR7fVsCmBQBM3dvq/A9pT8t0xRKWuDB+MB
 z9+z6a8ZDWDnUBgWSQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2ggX-1vjKwz388N-00CeSV; Fri, 30
 Jan 2026 13:14:38 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 30 Jan 2026 13:14:24 +0100
Subject: [PATCH v4 16/16] qemu-colo.rst: Simplify the block replication setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260130-colo_unit_test_multifd-v4-16-7115ab6f0e77@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4343; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=Vq0uip/eSPkRlYDXg+iQ5EdKb/P2Q7zchodJcpyMdqs=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpfKCmCCGxH8PojAWVB+yD4skN3KDALmn2/nicL
 42YctMGSCyJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXygpgAKCRA1qwsonF2y
 WP8+D/43C7VmZHDy29QPSsCVV6DlwEEnFRSGcoOYtqiqsvF8FYL+BSDB9n4GZ/r3aWbFviwSAeJ
 1YYWcATiXQT/oiRaF52mTMjWP0+jm7UWPE0H7wUbTAPKrbQnRc8PSH5MoVtf/6PAfzaBJota4X4
 TS8+44wz06reXTW+6aTGyBqQ4nNSHtf1av97EOqX0gSPLMqjjZEC7/MqnzXUlJDNcWKj4EkncIi
 18fID65XftaL2QXfDF6vf1NT3gGOATn+x+SfeN8zDlfkj49i9KMdLrkTxfogQS9FY6fC1qXzTPo
 0F4q4Klmm/4OcBTSoW1GTWTOSK7LCc5IJU+Na1XGD/uI5P4hQNWzu+qWvAHuZ+Fjc4S5ohCyn/P
 CA/0T2vU+mFeys1VqJ6laOr6rY045r6gCgkOk1XZDBvjJF5s3112M7sS3vZ5beuwjxL/4Hx4sYr
 Blj8cpbK1P3Ks8q6w8xegv8bJXY7U2fbJuXC/KuhBtDfz+xe7VnqsWb/FuoRSrOdkmc6YG9SNzD
 fdhNUMu8f0chdfj4yjiECQ7vSTwm+UFXQnEZ7xv3kZ3yB0Pkz8kDiRayh5wGEj6vMX1G/al3FK+
 JWiiio0Shk9+Intm0YWgdbNi9ddiXsWPdxY+6Oa1x+iy+EZXKrbsMALIsgpq+0k7eDAVayNzuSr
 ZzwHg7C7Lc0LfZg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:6DfoWfzfe/I7gYBFeB8lU6+iJQyAsiXhxjn44+n8pd5MDPGZQ8Z
 dHGYES0VctoglZxnUN21pI1eGSrVO0cwBQixgEpMiye+QW/LkSYq0ht6KnYlL7x3QJlJfs/
 ZMEXpuRFSqNulRcQvSMXDvXiaQbm+c3CQMBzGHp1h8D3MwDovuOudKrlEfpfMst6gHqNOKs
 pXYIihk3S595ZSCLahy7w==
UI-OutboundReport: notjunk:1;M01:P0:zMRuOmk5xGQ=;xnUXnaJpINRNiI4CaNSGMOXFcC1
 9hu3sRGUaskzOMLE4sI9RDxOqaT679YdtOv1wHTg2aOS44yKq2NYLh81ffCoxBQ1mxvZrGy1V
 mbuGVB5Hkn688THhuJfWBmbGTqyX8Pmv+Kc++Sx5u915eIyGd7cdQo4GKJDW/TUCj4jIAl2XE
 PAeuTkUk88yc7FvhnAd9niCe8eWaU547kUxsd30lavFzyuCMjXGbAwDA2HcN/Ba7K9j9pbK4R
 NOVNpNy/ADM+YVp63pSGarNEYak4CNlnQqgclvi/khBjy5j5UVyOpxDv68mF1WlK8psz2JM0i
 rpmwWBhUyxfw2iEb0BwCzuJD8c1+VhPE1Lg2fpVDrQXW7epRwJS3c+GP98SB6VlJj/NHJImc3
 BDZu0UtzjNcXW0x3p+4Yx/vklnVIWSHO3hcBXgff7RurNrUppQCzUCWJhlXkmyKEEwcTUBXrw
 N4p3ktdatjSApkqTMTCgOsy1Gdip1nHDdr27d5KFW9luZV4smOpoSm1MLXpLrOwoGaZ0Qdj4X
 fA+UtfW7R3levj+W5W3FxSfCJPhL1nlBM4PHW2D2dhJgr74Hbgfs/0hRNId2ag56YjWL1ADSr
 eSS2GVq7HQ/dzaa2UnER0sX2q76LxsariEC1WVzj2CqBXGZDVonfiPWAe39FpMcIftsJicuUX
 NNP4aOfKcM4SHrqx2n5Va0TJ9xg9te2+zrrtPclWcw1knvv09H8BRK0NMVtU1+yhnV94XnnjH
 wJJ5yHreF4LWG6mszL8kWMoefz6zcihaRjl9Vrkd63ZdXzqXaKusP8+yM3JxH3ELrsKi006Xe
 zuxvT4sGVCkavMnE8oVvG7bCicRnLbA8eED6IZdYjs+Eeik7ShvgRxSdKGaioTcnOhubwieuV
 +9F93xXnzQfSy0deLRgiEKzVCuzF7+6RXJlV8yiXFn1gZ4tZ0fcvW4cmHEnsMNnj+mg8CwD/f
 ph4XvZBgBy/V4ibVudKDtMfcnYNftlRznMjuHNcthF9rzoBt7nrb169hpOsfvmbmEvQis8vZY
 ZGZv5v86yGBFAz6/xqf/O7fJo10j4SOYXQZHvd9JubiceZvyB8xIdpdtDNDMl9Wc1axrYYZ3E
 rLTO++mUaDsdCX5TFNJVR5MlNvqLCo2JWu0s4osJnkMd5o+D9EUelFTQXNtJKFcyb9YZtDx/a
 6rHxphkm9uD+dbJxxqE7xGBQ5SKGQH0JD+i9W2nDg/+wctELGvC6/N77150DjBTdqFSfbmlmD
 JWd41wmqOzsponpId05W/efE/CJkk5gPs8advPkmNpOpQyvduk2CitXnIQZuoqf+uVu3zwnVC
 LCTzpGBu3sKZUGVAWVDyNw+rBDnljhel2pPQ5tLjHD5hzI11r+try5c+BvyUG971nPX1pLnY1
 q2Fk8pjcNGwtx3XnXlb+K6HU40mSAUMFtSumq+aECvLgM8xN7n+ljj5u+vv4R/I5ShjWyz+Rp
 pgcfNXobTQLisPpzQjLiguLjMW1qJqL9RQmhAnC62PWLHh3BmrfIfgcgFDMQ1ig007xoEhBFP
 hMHG6YiNOLFimWWHmE79XyQDbA7bvymJj7AUmBqfWHDhl5luWFNielkf7dDLp9/AKfN6WBU2q
 HzGjnPCiFOtIhVT88UdOY1qDO44hDpv3DqPPItmt8Jkpn/kzWmcDAkc1D+5a8esNBS4s2GQBo
 8txmpddmy2fLPUkkGUbhHvGVDBZM+HlSWUbXkwvH4HY5ZB9kwqpZs80sd1JkwL7Pv3i96Isoj
 Vz1NnZziGdqy18b0lJkkNFlhIl7koWjcdPxH2TmIMc31LugbYc5OPfDkbCYVZg2be6hc6c09w
 9T9BGtfJV6Yj5Pyu3X67383qCGSoD8AkshBu1QvSjemrGrDtFY95msGAYeAL1Jgaeb6wPOD8k
 lsVVb/FCazm3Vcloo9RWSBdVhstZ8QE6RnDJcHsllW0hsTEvb2+0VcR1J6ltYq1v1ZJZhmqWD
 R9sJpix1/g5ehrOuGQQQUHFx5N8O0Mk9c3uE0OaaPuyBfT0Pm3EOO2nYofe46Rtbh+PDaQ7TQ
 /yRx0aFMBquqHfDDSyuIB09dEI1oGpxpOr5hqCdC2PFsNeyJ2sirWWYDuJKP97dyBuZs/rcOz
 QpoZlgH4ZOk7tsSuatOhLsi7ysMJDRTbgpk2ZmtgG76zEK29zsmIB3BtVKwPcuOn4wKRE8ieG
 mYezH2o6hQ0q1s2jnRKexdftmMmrZNqyn3NddiMGvJBKnj00CZAVqLUjB9pk4bKSlcsecJW3J
 HuJ+ZCV9C9O5jPEib1ou94VTEaUqK6TQHagMky5u/xZfhCZ9o9vWbbvMhAwQIBB1JtQFgvjv4
 5Eti7eGr8aq5cvfzgsfn+aMyTVOmAG4OcN5f+ukLXops5G0Lyk7DnclBiIKq/cKYa4xnDJkW8
 +SVcDNtE7wgFeFt+BBUKYqP82GP7cq6u2Vsv21ig1I81+t6n6BmOH/cnBbkDQuumetmeOo6oR
 R1NHW46z//rfJdXcatWt+MVvmoGHKdfjeGJ7BDIj81Nf02HnQKVoUgEGhT5avQIKtUxiky+X7
 OT/g22jVyCaTBD2r+b2cUp0W9h65oJkrvoqAJ8p2sAYhdzbz2RerDskhLcRQReiN9NGIyP064
 Aukvb4HoY3rX1YBSAbe4NT9gvGTaeGrcmteXc4QDN3VqLev+hEG3J1vyT3RchcTz61xUs6gNQ
 FPOvvW1sm/hoUlABZM1XcyZDgIWil4M9cWGph6WAFGAID932Ns/uN2mEYD/hbfjniW4zDbuCX
 ydQ0mhX4Ng5ljxHkxY2ynjLaRNTO8GBcF8VRDe75ftO6/6MzjWMiBBijXh3TmNE4/Ckj9xADc
 3RuFSr8wMUBg3lnwwH0JOqwDWCo7PqKjkA2VtyaecvE5pQJvvDgEtw3iZPk6PK88lMNBIL88O
 VTs5aWgzT0HK0H3C394ZBQWPSCfUC6aJ27PJTphiOSObsDb5SCCoKPiUqbl4h+T6xocllTYA5
 43ZQfsoVLKr6ccBZZ0PzIphn2ebHG42A9srg6ZxD+b7g0ELfOsdIrJNY126QsJWUir4FKK14a
 +CeR2/iVIKpvhb8QQiLvNVu6TwJ8ykjEuZTVV3ClO/F8F7AKp4LM4IAbjyYyPtAoZROEENgwW
 GD6khemPUcTeshHm5PYapdL+6mh5OiQ/uiV2IiFvver+eqyPBWO6htug98+Lg1Ui+Lp6jmXN3
 Y9BksREQOg/DA2X404siHVUsz6h5qyIK9rDog+IEp2jpwVHFMyUq4Ane8xuRI6eJSoV4OdsMj
 tCHpNwktP2e8HlemsqFNga6uy9elGReUAP16tEectfSUQ9jg5q2JTyapGB0vcXmW5rdXgx1nK
 DOPf5c2LPuZIDRGNltEbYHN+D5L1O4V3+0pccnmPITeyQt7sgzF4KP0OrkoB2MJ6CbzmlYJhW
 tCAW9oK54Splf5IamLZC9iQiIEfBCxZ9cmoLVtSnbJnaBuxR1lLCV3rWSz1ExMmy91wDp0Gxp
 hWYFVTdDRD72ZEmf9eKFsyDoq+wVOS368EY0PoS80ukjmFPXuIPoJLiqzDY2nxg7ynvQsNQ10
 rwDdE9ikg20tj8BmmgjETN0LEbxnwChck9gQiN/ybWcD/1Szox9so2ZWW0x8MVXepxrie/PHg
 A/n+hcPifq6hV2XQsed0XFXZEZemP0M9zm0xk5leGOwdNGAA3ROKJ9DnmTq9KJaELBl2gnLeH
 H/txLg7Wmmgp7dInbb+i7s/W2XfTG9z1F/Vn4trW3fWANYXmLW+/YotcRSQhLlRkxrfY7a/e8
 vgsY3ZhwEkrS71HqCABGQiciiNS2Lrt88COhcPXATbwttVOHrN4bYW64uQQBC3xWQZZqpqIa+
 0EmxcFBc1FqbwchCjc0cdniqeHRVyChjxaPLN1OxkQmWN/wuWrOjwcRt6XaP7PavtBTnXP8bj
 fDnJ5LNfZrp+kN6JsEGwc4jQdt0ijbnpeQHVPHa9HeiFxA6IhBFum6wrWrxOlOUb2T3dqSM5U
 YKa0NNCJOvGDDJQ8eM11J4ap9JCi0rhSyf2mdvMgFHrR5JuSJhMPH4L6sNyHRadlV3ae5wQNV
 3Tx1Nc5Cj6ckZb0OP9z8D5tRIMe5KRivvYk/YYDDpvwBDa3FVIvgAt0U+n6pxQgAMyyFG97Sa
 zMfCpA1+Yrg/pXiR9xvyqoKT+1Ezzb0gzZIGHxBcgdVbAmlPlvrJiEhr5Rjpqi05loZcsFg+q
 JbfN6kBWEm0qdlzZ0pl/M58N+wZMl7GT+8nzluLSRajfJqlZQ8ellQfzBAxL5y3rHx5QIzM1q
 MMG1q0lCm5QfRLKciu6m6n43rv2ug/eTOr1qqExAkCb0ZaC55bFuEhROfInuHmY0NJyiriFkD
 6OsH1bzl8CDwQ1uTm56/k/OqaWPxYoaS9y4NP1EyqKxZpa/v5cfRo85fgxqw+mwDGiLI1fezK
 cEndIJh4hEz9szr2t/RFoI40VrKu2aaX42c1ty621PZ3aDjGCL/uMSo8FJk56wfA3TkyxHQdD
 kXdCjP9mmnaWRchnXG65KzGGdLGcTx5LsYYxYUwtVp46bwXpyMqoKudIAbjB16PUE/NeuboQZ
 H6WCaQtbQ27pO6oRArd9rHi7p+KfkOt1zjbbUxJd/imI8UYWudNL78lcuXnShKlCh1t2s59Mw
 aqIsADz3hqjH9y9FV1RkETAFQNEXTfhFPF1ceLaXoMktC6DU5tLJTFSggppoTkU8JVeBzzt6W
 X1HLHg+j6b+ROho05hH+0xZQ5z4LtlE3zMTfqdzb4LqMYou18En3+rTr7wPm/27na5+9vfwGC
 sVdX+lXyWp2cDq/PyQG8c7Y85Pp8gIR4OinQhyXakI4ZnVeYIykDcf6rcgDJqVfd7wARVBokh
 H9VNrLqx0ndCAl2C/2MwOWVJp0vmZwCg35qMd9+1avtOn9fJRGsC3/d7PSw1L8CrskZuMxVDl
 k8byfvekIKSa1Jaw7QbYp/Cl8PEUa6+w/WQZHw5RBSGVOGEUrKCr3pq0/UsKN4vdMUdeSBB1i
 9wnbdyGKktxHtDVbo66hpBo+aNFiDLEintc/jLkil1L9SsgS9INnKBSZw66SoxD85bj/MOQSi
 dkenltdzDi074YIKojkj+iRIgl0w0Tk6M0N1/BGQV6EHROqfS52fotCWgOw7K0Z5H/Hev/UHX
 Qz6xy1MimKRwcZtv5z0CkGGGiqDwikUVSFiyuZFLfbE/R569iU74HVMuX/mkPstMHmILC2fWB
 6dwo6oAO9VTGSowTXBuQed9UIV/3A
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
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

On the primary side we don't actually need the replication
block driver, since it only passes trough all IO.
So simplify the setup and also use 'blockdev-add' instead of
'human-monitor-command'.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 docs/system/qemu-colo.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
index 75abbd80298df79223cb8e70064a5dc83d70f4eb..f7d3b6439cf3401a58c4126342=
39d1a43999a10e 100644
=2D-- a/docs/system/qemu-colo.rst
+++ b/docs/system/qemu-colo.rst
@@ -240,8 +240,8 @@ Note:
 **4.** On Primary VM's QEMU monitor, issue command::
=20
     {"execute":"qmp_capabilities"}
-    {"execute": "human-monitor-command", "arguments": {"command-line": "d=
rive_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,fi=
le.host=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Drep=
lication0"}}
-    {"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0",=
 "node": "replication0" } }
+    {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name=
": "nbd0", "server": {"type": "inet", "host": "127.0.0.2", "port": "9999"}=
, "export": "parent0", "detect-zeroes": "on"} }
+    {"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0",=
 "node": "nbd0" } }
     {"execute": "migrate-set-capabilities", "arguments": {"capabilities":=
 [ {"capability": "x-colo", "state": true } ] } }
     {"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.2:9998" } }
=20
@@ -269,7 +269,7 @@ Primary Failover
 The Secondary died, resume on the Primary::
=20
     {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "child": "children.1"} }
-    {"execute": "human-monitor-command", "arguments":{ "command-line": "d=
rive_del replication0" } }
+    {"execute": "blockdev-del", "arguments": {"node-name": "nbd0"} }
     {"execute": "object-del", "arguments":{ "id": "comp0" } }
     {"execute": "object-del", "arguments":{ "id": "iothread1" } }
     {"execute": "object-del", "arguments":{ "id": "m0" } }
@@ -309,8 +309,8 @@ Wait until disk is synced, then::
     {"execute": "stop"}
     {"execute": "block-job-cancel", "arguments":{ "device": "resync"} }
=20
-    {"execute": "human-monitor-command", "arguments":{ "command-line": "d=
rive_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,fi=
le.host=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Drep=
lication0"}}
-    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "node": "replication0" } }
+    {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name=
": "nbd0", "server": {"type": "inet", "host": "127.0.0.2", "port": "9999"}=
, "export": "parent0", "detect-zeroes": "on"} }
+    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "node": "nbd0" } }
=20
     {"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", =
"id": "m0", "netdev": "hn0", "queue": "tx", "outdev": "mirror0" } }
     {"execute": "object-add", "arguments":{ "qom-type": "filter-redirecto=
r", "id": "redire0", "netdev": "hn0", "queue": "rx", "indev": "compare_out=
" } }
@@ -341,8 +341,8 @@ Wait until disk is synced, then::
     {"execute": "stop"}
     {"execute": "block-job-cancel", "arguments":{ "device": "resync" } }
=20
-    {"execute": "human-monitor-command", "arguments":{ "command-line": "d=
rive_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,fi=
le.host=3D127.0.0.1,file.port=3D9999,file.export=3Dparent0,node-name=3Drep=
lication0"}}
-    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "node": "replication0" } }
+    {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name=
": "nbd0", "server": {"type": "inet", "host": "127.0.0.1", "port": "9999"}=
, "export": "parent0", "detect-zeroes": "on"} }
+    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "node": "nbd0" } }
=20
     {"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", =
"id": "m0", "insert": "before", "position": "id=3Drew0", "netdev": "hn0", =
"queue": "tx", "outdev": "mirror0" } }
     {"execute": "object-add", "arguments":{ "qom-type": "filter-redirecto=
r", "id": "redire0", "insert": "before", "position": "id=3Drew0", "netdev"=
: "hn0", "queue": "rx", "indev": "compare_out" } }

=2D-=20
2.39.5



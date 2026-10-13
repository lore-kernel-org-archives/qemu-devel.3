Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098A2CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGhg3-0002gN-Vv; Tue, 13 Oct 2026 14:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xGhfz-0002fU-Fl; Tue, 13 Oct 2026 14:56:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xGhfx-00057Y-SF; Tue, 13 Oct 2026 14:56:39 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DDpICG148960; Tue, 13 Oct 2026 18:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GqdGoi
 q31WhAEXRD61BSBGDSHgNgn7XYqpdq3YXfI28=; b=pys4FgiaFrpK2s+8DdHS8D
 u6K1mZyBaH1qBf382tSbyWvuD5wSX+jC1TwFzKcPYWXU73m2cTXwozbHbcaWimqQ
 oDxbzfur5afW0rDXiA+DR7cgTr/CUUXHAPs+vthcsd4T59W3SCE/spEdFnz0o4hx
 DToIjfmS2Yl1oG1+Sdbzxb9iTIRF5kHobg8ao3fDIWuh9DkJUy5intvEbFnWddVu
 t6WRppA6kE4qq3NNffDXP91xxQCY/yjoZVNonDztgVs2PnDmgn8X7TTUuwF9ZRuY
 ewGAuPszWbNvKB2Tr5ccQHVVATS2SxyqGVzvHf7AvPxjArByGrD4EwCK1ikHzCDg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhg9rt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 18:56:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DIFpAS2709272; Tue, 13 Oct 2026 18:56:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h3nst-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 18:56:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69DIu3TC44302622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Oct 2026 18:56:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D9B320063;
 Tue, 13 Oct 2026 18:56:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32B852004B;
 Tue, 13 Oct 2026 18:56:02 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.35.59])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 Oct 2026 18:56:02 +0000 (GMT)
Message-ID: <3d7caca8-e1cf-47af-bfea-810986174fe0@linux.ibm.com>
Date: Tue, 13 Oct 2026 20:56:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] tests/functional: teach tuxrun about launching
 gdb tests
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Xu <peterx@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Song Gao <gaosong@loongson.cn>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
 <20261012170330.1144446-10-alex.bennee@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261012170330.1144446-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3NCBTYWx0ZWRfX/+kPkQLrhGXe
 ft/zuVevIwo6UcR70lOqg3SnjMbqbWKu9SzGKPjB1rKUytjgLbWAqx7zxAKnHqkcz1n2yTNk95l
 fxeYxu8aEO5NNKS44Q5NvpMYBBtvEZs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3NCBTYWx0ZWRfX6kKH9Z/o7iDI
 ZexIKfQGwfyEXJKhwa12b3oyRrRrZXwLACJXJLBcLbpOaTmd/D1uFw3Jcw8tSJlSLfc9J7d7zIj
 KA2X2TOpnKKBKD11xbvb7KQ+ISE6wtXeLumGWug1IoNeoCWrjP3CDkThDC6GsT2QZb4HPZr+FWf
 Jb/SUzYHHiHZ5j4Lq1SEXuUcSX8hhYOrkOxn625dcVvmavtfjH+iXZJuz1y7R3Bzza1UKXVPGJ7
 W2IGq3FMfz/9nB3PE0LpXH1BbGE3tXVAO9nu17ZvPDVr8eBUVS/1Jt9Ti6gTLWiQUq/KqSc3w4R
 bRDpRzM/2L1YH58zXpTbHxeUTwcwWLofNMYa52lp6PbQ5UjVV3puT94NO8AteinT4Orb7Pp2N4X
 PtKyRuxhrDfjG941YBSJUiZ/OsiliQRCchPq7MA1OcEOyZ7oYIYIDGQWhH1cj4cUihEtGCnIqIK
 Zzy9RWEJqPXKuliJcVg==
X-Proofpoint-GUID: hAiN5FtxTAiXva5wsVdKzCbTSnBa9gr5
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ace7eca cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=KKAkSRfTAAAA:8
 a=vPZ34w9Z38mvNuj86ZMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: hAiN5FtxTAiXva5wsVdKzCbTSnBa9gr5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130074
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 10/12/26 19:03, Alex Bennée wrote:
> This resurrects the hand run test script from d84842be6c5 (tests:
> remove test-gdbstub.py) and modernises it to use the shared test
> infrastructure for run-test.
> 
> We then tweak the common tuxrun code to over an alternative "launch
> via gdbstub" helper which reuses the existing code but:
> 
>    - needs a vmlinux with symbols
>    - extend qargs with stuff normally added by vm.launch
>    - passes kargs directly
>    - runs with the gdb run-test script
>    - log the run-test output to the console log
> 
> Message-ID: <20260930164649.433573-13-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - add self.vm._machine to qargs
>    - drop leading spaces in print () calls
>    - add register read tests
>    - use gdb.Breakpoint for hwbreak as for swbreak
>    - drop flaky symbol evaluation, verify hit_count instead
>    - explicit gdb.BP_BREAKPOINT for CatchBreakpoint
> ---
>   .../functional/gdb-scripts/kernel_gdb_test.py | 174 ++++++++++++++++++
>   tests/functional/qemu_test/tuxruntest.py      |  96 +++++++++-
>   2 files changed, 261 insertions(+), 9 deletions(-)
>   create mode 100644 tests/functional/gdb-scripts/kernel_gdb_test.py

[...]

> -    def fetch_tuxrun_assets(self, kernel_asset, rootfs_asset, dtb_asset=None):
> +    def fetch_tuxrun_assets(self, kernel_asset, rootfs_asset,
> +                            dtb_asset=None, vmlinux_asset=None):
>           """
>           Fetch the TuxBoot assets.
>           """
>           kernel_image =  kernel_asset.fetch()
>           disk_image = self.uncompress(rootfs_asset)
>           dtb = dtb_asset.fetch() if dtb_asset is not None else None
> +        vmlinux = self.uncompress(vmlinux_asset) if vmlinux_asset is not None else None
>   
> -        return (kernel_image, disk_image, dtb)
> +        return (kernel_image, disk_image, dtb, vmlinux)

pylint complains that unpacking in tests/functional/sh4/test_tuxrun.py
will now fail.

[...]



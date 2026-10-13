Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8167ECC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGiE4-0004qf-6v; Tue, 13 Oct 2026 15:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xGiE1-0004pe-Hg; Tue, 13 Oct 2026 15:31:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xGiE0-0000At-7B; Tue, 13 Oct 2026 15:31:49 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DE6utU1774676; Tue, 13 Oct 2026 19:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wDX4wi
 W8zy2G/353cDrzlRTJ1TqPsfPhXDgmnUjog1E=; b=ehgUTfCb5fCuNJs1XMOnnr
 ASETNSpZUopgsCKQ8uosA27LDedco1YxBAZJNpSrHEHSXuBNzDgRBJL8XQrUcnLR
 Eii5Q9lbffCHdhH9i8TRnDHL4NtGHuKavgrbwbUmGMUk5TDLm1famlMzeyyqKIIX
 TwrAEhWxvthuGYqiW1CT4t9Wc2idp8e6qewog2qPVckWyP5r8/hhNv7N6XR5VGvE
 K3SmTrvqmYCKz2d8KwTy8US/OFV+v+fXvgzx0hZOdDJVAEcaDH51Wn6SyKcGXMtB
 0eNLBgaxaXtQY0m4KsGb65urURvdKYDWD7cbt2vw9I4l7Xhoj0dzYm/eva+15K6Q
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwj03dw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 19:31:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DIAPPE2667524; Tue, 13 Oct 2026 19:31:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vv1fv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 19:31:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69DJVPMk30146930
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Oct 2026 19:31:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 378D720049;
 Tue, 13 Oct 2026 19:31:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26A7C20040;
 Tue, 13 Oct 2026 19:31:24 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.35.59])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 Oct 2026 19:31:24 +0000 (GMT)
Message-ID: <56a6a19c-2087-4a38-9012-25a996911674@linux.ibm.com>
Date: Tue, 13 Oct 2026 21:31:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] tests/functional: update s390x tuxrun images
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
 <20261012170330.1144446-16-alex.bennee@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261012170330.1144446-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3NiBTYWx0ZWRfX47rYlvtf+LOS
 hVFq1DmNEQKrLzMaIyW2m10OMVCMC+5dzM1cvwx5vezT2CntPlE4vyMU93H2949vWjq3ZBtBJw3
 znmUKtPNdBoJXyAvR25ko8Xnom6pUIanhvHtGQu3lBu3+ZsA2ZBEqgH3yCcITukbtTCFs22P/YV
 BXFX1bo5j+KRvHxOS+bqa7dAGwNBDsmQFaNC7Yjchbxfmq2++956yTaE+xzNX7RHBgtCNv2pkSk
 OtcGZiZxlPYsqheWQTBtdi3ftMemhc1M79WobC3qCqmeTZFeyZ+hR0kGGB7h0vxTiaGLWX10XKF
 Gi1b+/MsINcwjGOh3XQYtiWsQgVy8LFi6w1Y9CcFefN0I6aWloUgDsL8QV1WaKxeKp7mFtGSg8c
 nR367V6hA0TVGuUeVpq6yh1Ty9hsdR0oFysSBpX3oizb/giuT5VNs6J+rIuQC1SQY3I7a46viSc
 CaMjDDewkLhrwOC6f5w==
X-Proofpoint-GUID: fNEoas7DTWDteFpNJZC82r7qf_42qi23
X-Proofpoint-ORIG-GUID: fNEoas7DTWDteFpNJZC82r7qf_42qi23
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3NiBTYWx0ZWRfX2p32qRqvnK3k
 /EIZMmr/hgkoZVsPiIn2P6fdg0Sto7pm+csP2EfPsUBt3AdQoTaOA91s6sSCLRj7q377ONCWxqA
 xP3OvgIF1/+1NtcktNrCfOvPquGIK5c=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6ace8712 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=0FnjAz-au7Urrj2KuSUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130076
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
> We now split the fetching of the buildroot image from the kernel
> itself. This is because we will want to access additional metadata in
> future tests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/s390x/test_tuxrun.py | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BFA606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 22:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dtDwzu9L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJIc0-0006uM-1e; Tue, 20 Oct 2026 18:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xJIbx-0006tF-FN; Tue, 20 Oct 2026 18:47:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xJIbv-0003db-Gg; Tue, 20 Oct 2026 18:47:13 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KLETM33559397; Tue, 20 Oct 2026 22:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tFsJ+w
 Xq1WyUA3gFOS7fAsgH3ClAblC7xG3zdAoVRMw=; b=dtDwzu9Ln/21avLwnNII4o
 ooYzHOyGg+x2baU7hXCrEAxzb69CqWhm0HUxmymg7wbtIM9oYx3DnqLrrLI9W/Sz
 ugVVI7pCkzBFqMlbBJA3uQai9OrPeTamynqlhp04/TikwyH2Sd6nScZ2L0j5Zi9g
 /O2YxbmfdpSzNf9iGLGa5cZp/Xv5woofN71eHtJhDj6e525PJoCI9JfwAkX9tvqz
 d6sOh3YYGiTpcxG9rgL0muILIOCP2oAwWXP1vDA4z+CnVYlOD22oXGZ0o5srJmrB
 EHtX+tV1xpcXwUJn2MDjadDFeyY3lwDzSEd0x7EoAdbtLxLeuQlIk6xGtjVPB/4g
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a5sdm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2026 22:46:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KL4um62075791; Tue, 20 Oct 2026 22:46:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4he6gqarjs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2026 22:46:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69KMkk5j52298040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Oct 2026 22:46:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ABEBC2004B;
 Tue, 20 Oct 2026 22:46:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2CF020043;
 Tue, 20 Oct 2026 22:46:45 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.149.137])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Oct 2026 22:46:45 +0000 (GMT)
Message-ID: <7a3867d3-5fff-462e-9aca-5dcbb437d883@linux.ibm.com>
Date: Wed, 21 Oct 2026 00:46:45 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/19] tests/functional: add tuxrun kvm gdb test for
 s390x
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>,
 Anders Roxell <anders.roxell@linaro.org>, qemu-arm@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Klaus Jensen <its@irrelevant.dk>, John Snow <jsnow@redhat.com>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
 <20261019192704.3220373-20-alex.bennee@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261019192704.3220373-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA5MCBTYWx0ZWRfX+5hL/WR4B8bG
 6LAR1NwasRtfbZluonWSvZ2YWqqwgn58IzfuLdSsk495ZUBNgeo659DR6x7FM5vVn6NhzRDMR0X
 wibBrT78Sl/nIrOy6ot2vS0hOnrDpBc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA5MCBTYWx0ZWRfX0KGopqc+CLvr
 UuBZ5aVMzV4K11EF9ep4VsL5BaOOA/NyZy0RkzC5XEVz0Ulju2NMMmSX3SjdhY+FgS4S591EgZ0
 ux2QEI0hcYp2NVdj3KVfi75jEXK+KLNkwTKBO/82oh5Vt1gcP1ccGtR2lGswzFFAalPxrkJxkew
 9wHNY/3xYR9jb0XFBvy4TLjEI/eeZ1ieqQzXxCguie/ARiejTCuhta1g1gt/qbNN1E7TFgcPMvo
 hHrk3Hou+k4fcSh/9aXPhFcd62iUhgjysdx1h7SqAJH/S3z2HPV86axMUXIQoXSMN4t4esk211F
 0QtdyQo/hwstPyISGDdRU/UVn4UftBhzxSXs0ihq4dS4lZOl/ZO46RjyRwYAUbipWaRdBI7VQcZ
 39aNmZFbVs2gIB9VXLVEzmW9/ONbLsfAVlVB8tBHy3uwxbV8ndXjphb+JZR/9Q6/+KdakTeYQJk
 JAnbWXcBfoyfdjbA62A==
X-Proofpoint-GUID: zSsUxj3hzwDPQ-jghbxoH7bHZVcTBKEA
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6ad7ef5b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=KKAkSRfTAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=iwczQ0Bk7NEePQ-fpgQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: zSsUxj3hzwDPQ-jghbxoH7bHZVcTBKEA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200090
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/19/26 21:27, Alex Bennée wrote:
> As with x86_64 we now have the bits to add a KVM gdb test. A couple of
> minor wrinkles need to be handled.
> 
> The first is applying an offset when loading the symbols to take into
> account the relocation that happens.
> 
> The other minor wrinkle is the s390x only supports WP_WRITE watch
> points so we skip the other watch point tests lest we get confusing
> messages about failing to insert HW breakpoints.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> ---
> v3
>    - add symbol-offset handling
>    - limit the watchpoint tests
>    - add skipIfMissingEnv("QEMU_TEST_GDB") decorator
> ---
>   .../functional/gdb-scripts/kernel_gdb_test.py  | 10 ++++++----
>   tests/functional/qemu_test/tuxruntest.py       |  4 ++++
>   tests/functional/s390x/test_tuxrun.py          | 18 +++++++++++++++++-
>   tests/guest-debug/run-test.py                  |  7 ++++++-
>   tests/lcitool/libvirt-ci                       |  2 +-

Did you intend to bump this submodule here?

Otherwise: this now works and LGTM.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

[...]


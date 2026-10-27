Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220F8606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EjiqMbtE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjiE-0003je-4M; Tue, 27 Oct 2026 12:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1xLjhv-0003Xm-Et; Tue, 27 Oct 2026 12:07:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1xLjht-0007A1-SO; Tue, 27 Oct 2026 12:07:27 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69REEHgE1518777; Tue, 27 Oct 2026 16:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3TJ4b/
 Hd6N04ZVlz86s8b6ppKlGHuIm7hPByEEwmn/A=; b=EjiqMbtETTekPJdPlS8FGK
 HLvFiDdbxjfzUbDHELgvdowrsk0/LnCm0ibFMr+eJcuUiyLGG3tnZ4ZVsvqrzMkq
 RBE15kYKOBQaNHTvn5/S4iwOvqvXobm9pHQWq7ycn676K2Yy9YLJkpvdMVblygjC
 o3+O+jUEFOICkbP3zolWQsIGasRqlnrBqJhNfHu1g6eTBt2C2lm4Ysp/tv2sP+7x
 JP9xenPcrub/NIPI1grH6i8NdDNHHTeCU0k16WSKod2d25mP53f2r6RRHPsk0P7p
 ocP8LrWZ4aX7/nptNeaZ9W98PW6f8Cts7qR4XfdAU3nyuukeYUF9HIsMNov1yPpw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3g08uq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 16:06:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RE5NcS050452; Tue, 27 Oct 2026 16:06:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh7cvkny3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 16:06:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69RG6sn047186300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2026 16:06:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0783320043;
 Tue, 27 Oct 2026 16:06:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B81A2004F;
 Tue, 27 Oct 2026 16:06:53 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Oct 2026 16:06:53 +0000 (GMT)
Message-ID: <5d28efce-0344-4172-83bb-ed8e97b802e2@linux.ibm.com>
Date: Tue, 27 Oct 2026 17:06:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/19] tests/functional: add tuxrun kvm gdb test for
 s390x
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
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
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261019192704.3220373-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae0cc23 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=KKAkSRfTAAAA:8
 a=20KFwNOVAAAA:8 a=r6AxLgfQxGK4Zs2wc1wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: xDct3LEvUxMBIVwl5hbioPgGSj7tnRQ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MiBTYWx0ZWRfX3sPulsbWKr5n
 F/fttdqxkIX7mlQGy9cpJphn7uiAvr1nN0FoVW/lwwfxye8pOwvEFk8/FQ2Oqn5NZi1AlBIgPwe
 OkCyh7Q2CQrOdBqSDDxT44ZQnqMFMziHwj+6Xq8jOuMvkG8vbshT+5vY/H9lus2tWkk+dU2m/vj
 BQnNQP8RLpREkXQdnNOoTJdMd8S5BG6CEBr5tuCDB/VvaEbJKow85moFmY3rBUAAk8tNBOFg5j4
 /cIrNhLd0yXTmqf9ICQW6HarPG2eesnTCuB6ubj4P+QxWXO6ZeKImZk9P/SJZQZFPzwpLQjsqfh
 CVLI9l505+L8Zt9KyQ0JNtgY7nclsgZhJPioDgloYclzg1YkCYg1PMsA5O4uuxZy/y5FOq2Xj5z
 Yztjxb1eUK0zPillgtS7U2uZW0zur8UR/I4EnYbUg9f1Qdj9CC3bAQvVDQwfzsEWkoVIX/GeElB
 lgQyKJfXR8adzCI5qaw==
X-Proofpoint-GUID: xDct3LEvUxMBIVwl5hbioPgGSj7tnRQ6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2MiBTYWx0ZWRfX2DYWXk9Wbq5h
 o3aHNWQVHtCR5E/DJpRQpGiTsoBJLChNQvDiFNvnENlvLprPWcCY47IxraAvbZGyJT6gwQEXkAF
 yOEcPi7S3mpOkHk7Ak+f3zQ/CcxDI0o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1011 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270062
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 19.10.26 um 21:27 schrieb Alex Bennée:
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


Hi Alex,

on an s390x KVM host, test_s390_kvm_gdb fails on current master
before gdb is even started:

Traceback (most recent call last):
   File "/root/REPOS/qemu/tests/functional/s390x/test_tuxrun.py", line 53, in test_s390_kvm_gdb
     self.common_tuxrun_gdb(kernel_asset=self.ASSET_S390X_KERNEL,
     ~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                            vmlinux_asset=self.ASSET_S390X_VMLINUX,
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     ...<3 lines>...
                            haltmsg="Requesting system halt",
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                            accel="kvm")
                            ^^^^^^^^^^^^
TypeError: TuxRunBaselineTest.common_tuxrun_gdb() got an unexpected keyword argument 'haltmsg'

not ok 3 test_tuxrun.TuxRunS390xTest.test_s390_kvm_gdb

haltmsg was removed after review, but not from this patch.



In any case, zhank you for enabling s390 gdb testing,


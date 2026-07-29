Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A1EC54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp2PO-0000Tz-Ek; Wed, 29 Jul 2026 07:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1wp2PM-0000Td-Ax
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 07:25:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1wp2PK-00087V-Ei
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 07:25:08 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TBHfod3954914; Wed, 29 Jul 2026 11:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9QD4EW
 OIE7H257RjVt8bF5OFna7Ne9oNiudFWk1haN4=; b=Glx+wVXkKWbznfw1ca9DfT
 s/1ZeIWbidF9jdo/DaW+qH/Zy+6PBgJKUu96nNSxBP09TNMDct9TjET2q7lt5jKn
 xtkv9/dRxNGfGQnp5VuETlMnzJ41aAAosFj661npgRUaLyYZULfBuGi5s8rMbAw1
 n7/Bi9OCY8aymQ2oUGR2qqLoRg0pfal6peP1Smd4bOpBNH2h1hkkxYVpeYlqOGrl
 7TiOgoQEx5C1BEklVI/ZVao4u9dihmwVvXGuvVZK1fzvVtxWcr/M1DADDRl6KAnv
 Wf2DB1dKqSWchqt+9HYguNZweUxzzVDHtxpOfHKMlqtVH7NoPFA2UwCqs57zle/A
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nsjnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 11:25:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TBBeP0020882;
 Wed, 29 Jul 2026 11:25:02 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y65qr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 11:25:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66TBP1Nn30802534
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jul 2026 11:25:01 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D18758043;
 Wed, 29 Jul 2026 11:25:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03E4258059;
 Wed, 29 Jul 2026 11:24:55 +0000 (GMT)
Received: from [9.124.208.184] (unknown [9.124.208.184])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Jul 2026 11:24:54 +0000 (GMT)
Message-ID: <79992c9a-1267-4512-aca2-7187e0925789@linux.ibm.com>
Date: Wed, 29 Jul 2026 16:54:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 000/103] tests/tcg: run tests with meson
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, asahu1x@linux.ibm.com
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Aniket Sahu <asahu1x@linux.ibm.com>
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA5MyBTYWx0ZWRfXxzHmpoZfvevt
 ZAzm1Eq9JNq+AvCvAZ2W55Sfk9r/2JOVwZQDXpm12r6OjAbs+5ql0wIsTx7RX2IjqwbMA07/vUH
 sf5TxutBp7uQghcZY3miCXzsGEs6t1A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA5MyBTYWx0ZWRfX1mQXM8fHlJC6
 MD4cj10uDVgwke+ydQL6sN/TC2s6FIIPD/4/C6UOe3J+jFNUztpPIECYi+vK5m3QGQtoSJAgLcB
 0D8mKwIAE5Zk57iNg+4v7ynphRO/uamScoULTUlckbxO7CVhBqEG+0wvp9Y3YbuvGsSWp2SwyVm
 yr/i29gRYKPNQvSuiaw0akTRtaMkUjmp2FjrPyYW4LEw2z/37xbaIs5HNBmt4mVUe1XhaZ6exsa
 1oupLdg0hfyRUVhGD9rrO5SHghYUuLIizrhJFRSXz264bbrerLAmIGF3rv1tI9lWKNSP8sou6RK
 Zn4V720C5fTLQWBbES2BE0GA5U5+feZkqkqb0lKGPJ8XmAW2rMfKc/EQtRAlmBHihlx2nf2WfG0
 14FEYMrAKHBMW7uF/Z3GQEpmWRWdz/a6wo0O/rDf5CHVhsAfmdWOjIxoytDuihGnFcQNGSFPjtI
 HvSjWOr3448QYvp5mpg==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a69e30f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=0E0gm9adgrEd7Zdai5YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QlNcJmatqyGkqcfwVsYKF1Ng91d9cUnn
X-Proofpoint-ORIG-GUID: kiWBb0exdgItLQpB8Ai0P7vIBV2A0X7T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290093
Received-SPF: pass client-ip=148.163.158.5; envelope-from=asahu1x@linux.ibm.com;
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

On Mon, 28 Jul 2026, Pierrick Bouvier wrote:
 > [PATCH v6 000/103] tests/tcg: run tests with meson

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>

Platform details:
   Host arch:       ppc64le
   OS:              Ubuntu 26.04
   Kernel:          7.0.0-28-generic
   GCC:             15.2.0 (Ubuntu 15.2.0-16ubuntu1)
   meson:           1.10.1
   ninja:           1.13.2

Commands used to build and run the tests:
$ mkdir build && cd build
$ ../configure
$ make -j$(nproc)
$ make check-tcg

Command output: The test report is very large, so I'm only adding the 
final report here

...
1476/1480 tcg+tcg-xtensaeb-softmmu - qemu:xtensaeb-softmmu-test_sext     
                     SKIP             0.00s   exit status 77
1477/1480 tcg+tcg-xtensaeb-softmmu - qemu:xtensaeb-softmmu-test_shift   
                        SKIP        0.00s   exit status 77
1478/1480 tcg+tcg-xtensaeb-softmmu - qemu:xtensaeb-softmmu-test_sr       
                 SKIP             0.00s   exit status 77
1479/1480 tcg+tcg-xtensaeb-softmmu - qemu:xtensaeb-softmmu-test_timer   
                        SKIP        0.00s   exit status 77
1480/1480 tcg+tcg-xtensaeb-softmmu - qemu:xtensaeb-softmmu-test_windowed 
                         SKIP          0.00s   exit status 77

Summary of Failures:

  117/1480 tcg+tcg-aarch64-linux-user - qemu:aarch64-linux-user-gcsss   
           FAIL             0.11s   killed by signal 6 SIGABRT

Ok:                228
Fail:              1
Skipped:           1251

Full log written to /home/stuff/code/qemu/build/meson-logs/testlog.txt



Failure noted:

- aarch64-linux-user/gcsss: SIGABRT on ppc64le host. Confirmed
   pre-existing on origin/master, not introduced by this series.
   Filed an issue for the same: 
https://gitlab.com/qemu-project/qemu/-/work_items/4106


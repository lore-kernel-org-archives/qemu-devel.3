Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA76D778AF
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjN6G-0007bv-9a; Fri, 23 Jan 2026 14:45:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vjN5w-0007Sx-JV
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:45:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vjN5u-00014P-Jb
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:45:24 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60NBmG2q006269;
 Fri, 23 Jan 2026 19:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=blyLuA
 /24eMP7hCJqWn3m/d8fnlOKeX4ouNMhuBfie4=; b=TZVnqXvMdrWRaS9VVAGb4m
 yIcpD6521JWXDCm3IJ1wtI6Qr20nAno2kbLRmEAaqKhjngNwMgL5Xv9LIAEdJQ3W
 Gx7PeET3Ily86EIwYUkJIUMhRCQfpVflGtP57pO46geQHeuqgx5URHhYrJ0gxQdB
 Tikdscgg6KGJiYe33w+KRzRfqvEmnF1yVKePrOFTpL4Z8xJN0nBegfgdxELOfTPN
 L+PEj2FHbTGRVoQQe4TBO2ix/DlAKPLIvyuOmlf/qnXlBD9qQCi7U6LyBhhAUW0o
 SEt5d5rq86jOludxpUNVTchX8xiqxKIumaEVwnPO7zeP71ruDAQfTg0L75lrRHvg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23sj4s2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 19:45:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60NHGXbn009274;
 Fri, 23 Jan 2026 19:45:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brp8ktxeh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 19:45:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60NJjC3g57541080
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jan 2026 19:45:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7845320043;
 Fri, 23 Jan 2026 19:45:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04BFA20040;
 Fri, 23 Jan 2026 19:45:10 +0000 (GMT)
Received: from [9.39.25.49] (unknown [9.39.25.49])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Jan 2026 19:45:09 +0000 (GMT)
Message-ID: <652b1544-e008-441d-8d15-b31856b0359d@linux.ibm.com>
Date: Sat, 24 Jan 2026 01:15:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REPORT] Double deletion of output directory in functional test
From: Aditya Gupta <adityag@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <aXOGKb88Yho2jb_o@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
In-Reply-To: <aXOGKb88Yho2jb_o@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Kq5uGlYQ4zMyhePkfQqhRlZ1X9jL1kAr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE0MyBTYWx0ZWRfX9A4CHpUQd+Ho
 kPneAsUkAZPDbdsW4v/P/jY2oyOxhRa3S+LMUipRatWEgr2VOPb3CRqYbNRGt5fSvyxrexOp/cc
 q1vivEd1yQ6mXF9eVkMAlxzFtRQr1iGO6Rp0UFwLef9jVr5mvQDMa6rX0lw55EKNfDnanhRjlhv
 tuPVNvVZ6udbkzTJrl5MVCmoCq1LhP/Pg9K8ve30rkXx4df/VVUBSziT5dzPGUY5hQ9XK5UT8Oi
 9G1M2Hg4UPauAV8Am2ykUFxN6C6AXq9UKccM4/m8Bg/kI+UdJ1d2W152qSpqMVVyA4mdsfk+DuA
 5sT8I/rZpQCRb+OtMSeky6Zkcf9A89KV3kRuWymBpU5sin3RR9fctBiLs/ZWHJX0wpYZ6+mibwM
 wdrt3RGb+ndeT4y+d0NpPJK26PrGP7sLqfLX5I16uwdorrZS9kU7NRVri3Qu8pBmPux6GBcXxOx
 nrHXr4UjFH0zKwC3ECw==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=6973cfcd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=b0MIopuo0-AJcRusZvgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Kq5uGlYQ4zMyhePkfQqhRlZ1X9jL1kAr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230143
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

+harsh

On 23/01/26 20:07, Aditya Gupta wrote:

> Hello,
>
> I notice a test failure with ppc64 functional tests, which only occurs when
> tests are run in parallel ('make check-functional-ppc64 -j8').
>
> I believe the issue might be with the generic migration testcase. The following
> backtrace happens on error:
>
> 	Traceback (most recent call last):
> 	  File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 421, in tearDown
> 	    super().tearDown()
> 	  File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 238, in tearDown
> 	    shutil.rmtree(self.workdir)
> 	  File "/usr/lib64/python3.11/shutil.py", line 742, in rmtree
> 	    onerror(os.lstat, path, sys.exc_info())
> 	  File "/usr/lib64/python3.11/shutil.py", line 740, in rmtree
> 	    orig_st = os.lstat(path, dir_fd=dir_fd)
> 	              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 	FileNotFoundError: [Errno 2] No such file or directory: '<SRC_DIR>/build/tests/functional/ppc64/test_migration.PpcMigrationTest.test_migration_with_exec/scratch'

Git bisect points to this:


     f4e34d0fd56c25dd0c90722ed80a83a175160a6c is the first bad commit
     commit f4e34d0fd56c25dd0c90722ed80a83a175160a6c
     Date:   Fri Jan 9 09:35:19 2026 -0300

         tests/functional: Add a OS level migration test for pseries


- Aditya G




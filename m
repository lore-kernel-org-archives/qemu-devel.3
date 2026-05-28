Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1E8CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wScka-0001Wp-VM; Thu, 28 May 2026 11:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wSckZ-0001WE-J5; Thu, 28 May 2026 11:34:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wSckY-0007LZ-19; Thu, 28 May 2026 11:34:23 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SClOtA3139343; Thu, 28 May 2026 15:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WHD1IH
 WiCL0rXhDsBmRuZSMkNkcWT8cRbV2hC7RkFyk=; b=CLwXCRy3/UN0JthiIoTMmx
 pO/PRluz/zqMsf/gpBfIjyBfoXK/ZMKtq9L1fxGBELh5p89Ejc5E3G+FwUJySrJ+
 FLVt3SgaBUfXsKhOXcYkGFkLxetpxK+y4ifafd63dVFiDw3AfeaKOwlg6f7j6ePY
 z0n+yQz+eQxGJ9CjFbOvh1cQBss7OOqOmMsJywB/bAjKIwf/305nChr6KphElPwn
 UnD1ndmIYjLm7FwEE9DFI3JZwS1rt+2GuMcXxiFvBYitKJFm7o0aPD03Nz5vQOTA
 C7Q7EsSpy2UZff10e4Ki/LS6UXAChx/DWlboNkuTTERjRVPRFI0x3F8fX89hu9wg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee887km6a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 May 2026 15:34:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SFOS9a023079;
 Thu, 28 May 2026 15:34:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb8rep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 May 2026 15:34:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64SFYGUu17302124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 May 2026 15:34:16 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B58558062;
 Thu, 28 May 2026 15:34:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C564B58051;
 Thu, 28 May 2026 15:34:14 +0000 (GMT)
Received: from [9.61.124.159] (unknown [9.61.124.159])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 28 May 2026 15:34:14 +0000 (GMT)
Message-ID: <bbc147c7-0e70-4640-a830-2fa12f18c13c@linux.ibm.com>
Date: Thu, 28 May 2026 11:34:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/32] Secure IPL Support for SCSI Scheme of
 virtio-blk/virtio-scsi Devices
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260505201905.997996-1-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QLJYgALL c=1 sm=1 tr=0 ts=6a18607a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=88C1laGa05002lli46UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: aUr5ySUFYgJ5NyVAU1hleLqIhM3kcTvi
X-Proofpoint-ORIG-GUID: aUr5ySUFYgJ5NyVAU1hleLqIhM3kcTvi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE1MyBTYWx0ZWRfX9wqMVzU+9/p5
 nqkxzibHOkZgZvl5J2jHZvX3INYOAChY+CFng1JJVimET1Ec/8ddJp98kpFUT18oHkftkrlvAH9
 zd4XgR7nMJ1JUVCpFOkNS57nWUYftU4KQ4Aqhs8pesnZQ7CUxmgu0KcRpo9TsbL/ho0DCndqI/r
 vy5/I7Tvd3bKE5swE5Ohl6f5e8vriQkZBGp9IZpuc+Cw6genjUzlcwMV0hjZgRMgFUIc1AY/Dh+
 /0hVNzIYK2O6Da43oW1lZ8736blmexVqGyF2BsGVYZOJTqavyhPYT26fL+WGu/7LIOdujFrBp3E
 NqN1Ywjlqccmxu1zPJkladny4NGtXo29J8ttY8mcjFxvOEp86HJlTRUdiU/cLUMMwWSo2/7WHIC
 NRPQpix5D1kfT9OK4CSPZsuZQ4HKgON9ghyYk+B+LjJmWN2dmJYBKgtIzqoMWb20FqtPbcwzxsu
 see1iiGxtBK90QctZWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280153
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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

The Secure IPL configuration/state does no appear to persist across reboots.

Consider a guest provisioned with two bootable images, one is signed, 
one is not.
The stage3.bin is properly signed.

With secure_boot=on, boot the signed image, then try to load the 
unsigned image using kexec.

[root@localhost ~]# kexec -ld unsigned --initrd=fake.img --reuse-cmdline
Try gzip decompression.
Try zstd decompression.
Not zstd compressed
Try LZMA decompression.
lzma_decompress_file: read on unsigned of 65536 bytes failed
[  339.375817] kexec_file: kernel: 000000000915b573 kernel_size: 0xf85130
[  339.383018] Lockdown: kexec: kexec of unsigned images is restricted; 
see man kernel_lockdown.7
kexec_file_load failed: Operation not permitted

Initially kexec correctly rejects loading the unsigned image.

Reboot, then re-try loading the unsigned image.

[root@localhost ~]# kexec -ld unsigned --initrd=fake.img --reuse-cmdline
Try gzip decompression.
Try zstd decompression.
Not zstd compressed
Try LZMA decompression.
lzma_decompress_file: read on unsigned of 65536 bytes failed
[   44.654152] kexec_file: kernel: 000000009fc3b80c kernel_size: 0xf85130
[   44.774975] kexec_file: nr_segments = 4
[   44.774978] kexec_file: segment[0]: buf=0x000000009fc3b80c 
bufsz=0xf85130 mem=0x0 memsz=0xf86000
[   44.780416] kexec_file: segment[1]: buf=0x00000000f9e1120b 
bufsz=0x2dd2c52 mem=0xf86000 memsz=0x2dd3000
[   44.818676] kexec_file: segment[2]: buf=0x000000004f695d01 
bufsz=0x2f60 mem=0x3d59000 memsz=0x3000
[   44.818680] kexec_file: segment[3]: buf=0x000000008a75eb84 
bufsz=0x138 mem=0x3d5c000 memsz=0x1000
[   44.818682] kexec_file: kexec_file_load: type:0, start:0x0 
head:0x9c2a002 flags:0x8
[root@localhost ~]#

After reboot the unsigned image loads, kexec -e can be used to bypass 
Secure IPL settings.

Regards,
Jared Rossi


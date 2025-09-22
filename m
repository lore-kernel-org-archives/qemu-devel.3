Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09939CAC5AC
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 23:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0qGp-0006ag-KQ; Mon, 22 Sep 2025 19:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1v0qGo-0006a7-0D; Mon, 22 Sep 2025 19:48:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1v0qGl-0007kb-1I; Mon, 22 Sep 2025 19:48:33 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MIKkfr000347;
 Mon, 22 Sep 2025 23:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ijQeLZ
 Hw5c7jmAlS/YJ702IoBP17Ok9Njpax7PFWmcw=; b=JV6dTISaeYn1T3nALkVaL9
 VpYXD5x8GsiagclH1GhpmNXuAGJR1qUVL4kf6+VE/vfRgHxhaN5zZfjJndxT2IAv
 pKm/N2CTZLvYajdDQqB8WRHaLJxKxyccVzI2HvCsR37oDHSnlTM6bGx/4/eB9ik7
 zOIGzHRwTCFshSODng5+Tlu45+XlTnC24iR4el8xmgQ1veP+VDH1EcVIIq43Ki8U
 PnY1xyTWGvbR71WdHs05M6wgr+7P56Ep8rRMQolhBB2/E95KI/caE8tYpMF6Z6TA
 D74eQzQfBS4CyVZdBarlRzHdWEL7I+yrD2zbFbCtB3ZnI0B8Im3sDPcFD1UDN9vA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksbnwh0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Sep 2025 23:48:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58MK5d7c008311;
 Mon, 22 Sep 2025 23:48:24 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a6yxrpdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Sep 2025 23:48:24 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58MNmN6o25952932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 23:48:23 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BBC45805E;
 Mon, 22 Sep 2025 23:48:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 810CA58052;
 Mon, 22 Sep 2025 23:48:21 +0000 (GMT)
Received: from [9.61.173.107] (unknown [9.61.173.107])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 22 Sep 2025 23:48:21 +0000 (GMT)
Message-ID: <9db0e68d-b54f-49d2-b598-f8e2f69e853b@linux.ibm.com>
Date: Mon, 22 Sep 2025 19:48:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/28] Add boot-certs to s390-ccw-virtio machine type
 option
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-2-zycai@linux.ibm.com> <87ldmcz1so.fsf@pond.sub.org>
 <aMvE7Phd7sLvgj-J@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <aMvE7Phd7sLvgj-J@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JJNJ_iZ-EiBEs1YpvIUTHSKvFemxxKDw
X-Proofpoint-GUID: JJNJ_iZ-EiBEs1YpvIUTHSKvFemxxKDw
X-Authority-Analysis: v=2.4 cv=SdH3duRu c=1 sm=1 tr=0 ts=68d1e04a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=SqMvC5kiAAAA:8 a=VnNF1IyMAAAA:8
 a=nHXPdzz9ehaqDZI41xAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3GzNa28zmJEA:10 a=_o8VnCo6Hb5Oqlm6Mk7M:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX889SQ48dbPuM
 LcGgIR3GYNyK+fJn3yQNUv++cU9v5zyxBkE8ubmQTd0UWa/X8e6xFC6VcPAXL7Ku2iYbdyydteC
 g1SucZM3ErUui8ouc4INYLAyY/1Pu2Dd6tAEh4UfbpU44E+JPXc57fEX361kThXqaAbnukIGOY+
 CM736lIBw3OIMFvmksUAZnRpxmty+YthRbhj7EY/7kfRgsW/f5VCMkdeEjk/R739FlkszV1kbcP
 eyd83GasWpWt5idPrzY9PbbQifGkmu5/kioP4yfpBjA4s06r5wvUw+kcFs5dgZGXS3nPIVpCe0p
 /A+ka5QbVIWppo6jcZ5Lu6AJ7hCnw44ECYhKwNsydZvorCH391VfrRo6sms7/PV4hFNgzVL4cr3
 b8B9DKeQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/18/25 4:38 AM, Daniel P. Berrangé wrote:
> On Thu, Sep 18, 2025 at 08:56:39AM +0200, Markus Armbruster wrote:
>> Zhuoying Cai <zycai@linux.ibm.com> writes:
>>
>>> Introduce a new `boot-certs` machine type option for the s390-ccw-virtio
>>> machine. This allows users to specify one or more certificate file paths
>>> or directories to be used during secure boot.
>>>
>>> Each entry is specified using the syntax:
>>> 	boot-certs.<index>.path=/path/to/cert.pem
>>>
>>> Multiple paths can be specify using array properties:
>>> 	boot-certs.0.path=/path/to/cert.pem,
>>> 	boot-certs.1.path=/path/to/cert-dir,
>>> 	boot-certs.2.path=/path/to/another-dir...
>>
>> Given we can specifiy a directory containing any number of certificate
>> files, is the ability to specify multiple paths worth the additional
>> complexity?
> 
> The typical scenario would be point to somewhere in /etc/pki
> for some globally provided certs, and then also point to
> somewhere local ($HOME) for custom extra certs. So IMHO it
> is reasonable to want multiple paths, to avoid copying around
> certs from different locations.
> 

Thank you for the comments.

Since Secure IPL on s390x is supported in QEMU, I would like to begin
drafting the corresponding Libvirt interface and seek feedback before
proceeding with the implementation.

While Libvirt already provides a secure boot interface
(https://libvirt.org/kbase/secureboot.html), it appears to be primarily
intended for x86 systems, where secure boot is configured using the
<firmware>, <loader>, and <nvram> tags.

	<os firmware='efi'>
      	    <firmware>
		<feature enabled='yes' name='enrolled-keys'/>
		<feature enabled='yes' name='secure-boot'/>
	    </firmware>
	    <loader secure='yes' type='pflash'>...</loader>
	    <nvram template='...'>...</nvram>
	</os>

For s390x, some of these existing tags may be reused, but additional
elements will be needed.

Below is my initial proposal for the secure boot interface in Libvirt:

 	<!-- New s390-ccw-bios firmware value -->
	<os firmware='s390-ccw-bios'>
	    <type arch='s390x' machine='s390-ccw-virtio-9.2'>hvm</type>
	    <firmware>
                <!-- To enable secure boot -->
		<feature enabled='yes' name='secure-boot'/>
	    </firmware>
            <!-- To provide boot certificates for secure boot -->
	    <boot-certs path='/path/to/cert.pem' />
            <boot-certs path='/path/to/cert-dir' />
	    <boot dev='hd'/>
	</os>

I would be greatly appreciate any suggestions or feedback on this
proposal, and I am open to refining the design to better align with
existing Libvirt structures.

Best regards,
Joy

>>
>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>>
>> [...]
>>
>>> diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
>>> index 966dbd61d2..51bf791fe6 100644
>>> --- a/qapi/machine-s390x.json
>>> +++ b/qapi/machine-s390x.json
>>> @@ -119,3 +119,25 @@
>>>  { 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
>>>    'features': [ 'unstable' ]
>>>  }
>>> +
>>> +##
>>> +# @BootCertificate:
>>> +#
>>> +# Boot certificate for secure IPL.
>>> +#
>>> +# @path: path to an X.509 certificate file or a directory containing certificate files.
>>> +#
>>> +# Since: 10.2
>>> +##
>>> +{ 'struct': 'BootCertificate',
>>> +  'data': {'path': 'str'} }
>>
>> I'd call this BootCertificates (plural), because it can pull in any
>> number, not just than one.
>>
>>> +
>>> +##
>>> +# @DummyBootCertificates:
>>> +#
>>> +# Not used by QMP; hack to let us use BootCertificateList internally.
>>> +#
>>> +# Since: 10.2
>>> +##
>>> +{ 'struct': 'DummyBootCertificates',
>>> +  'data': {'unused-boot-certs': ['BootCertificate'] } }
>>> diff --git a/qapi/pragma.json b/qapi/pragma.json
>>> index 023a2ef7bc..66401837ad 100644
>>> --- a/qapi/pragma.json
>>> +++ b/qapi/pragma.json
>>> @@ -49,6 +49,7 @@
>>>          'DisplayProtocol',
>>>          'DriveBackupWrapper',
>>>          'DummyBlockCoreForceArrays',
>>> +        'DummyBootCertificates',
>>>          'DummyForceArrays',
>>>          'DummyVirtioForceArrays',
>>>          'HotKeyMod',
>>
> 
> With regards,
> Daniel



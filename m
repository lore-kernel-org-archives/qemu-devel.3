Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CCECAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Idb-0003le-8o; Mon, 29 Sep 2025 14:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1v3IdY-0003kz-Bi; Mon, 29 Sep 2025 14:30:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1v3IdR-0001uW-PO; Mon, 29 Sep 2025 14:30:11 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TAnE3G021623;
 Mon, 29 Sep 2025 18:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=i7lCCT
 yKP4ZelI1TzSOaAYEMe9U7gVHasN9AZColyNo=; b=UfUHd8kvUeD553IPlkuX/N
 mH6fh8bgE8vYG5Jn0TqF//yPKTLcduRE3wOgpXm77mTeM5JfAcLRy0jreiH/CoYo
 WbBT0KCtKL5fVl7SDbhIvjxQpYrGSHxQAfhTKkcxFNoU17WPQj1UwjT8xJ1Oxqfj
 IY+NgdxFWGVB9fZL1FaBZxP3+QbRc3Bl1ylYTrPk0+nbWTPEPUWGXl6GRnTjU0Fq
 43p+rOUtogqkTc1AEyMOVMneciNsOTSYkFrldPAz8Fqy1L6kQF4aN2XwCYAnFTu1
 J6XD0b45p2LWd8pZY2knXlnnKpeNCZON1UjlW1GPLSreUeggypqUhKyOI9BkSO6g
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jwbry0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Sep 2025 18:29:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58THHE3C001540;
 Mon, 29 Sep 2025 18:29:58 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evfhy966-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Sep 2025 18:29:58 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58TITuF826608326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Sep 2025 18:29:56 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5F9D5803F;
 Mon, 29 Sep 2025 18:29:56 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4962958055;
 Mon, 29 Sep 2025 18:29:55 +0000 (GMT)
Received: from [9.67.68.243] (unknown [9.67.68.243])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Sep 2025 18:29:55 +0000 (GMT)
Message-ID: <b093c8f4-e701-4c26-9185-e3d2add92bd7@linux.ibm.com>
Date: Mon, 29 Sep 2025 14:29:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/28] Add boot-certs to s390-ccw-virtio machine type
 option
To: Zhuoying Cai <zycai@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-2-zycai@linux.ibm.com> <87ldmcz1so.fsf@pond.sub.org>
 <aMvE7Phd7sLvgj-J@redhat.com>
 <9db0e68d-b54f-49d2-b598-f8e2f69e853b@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <9db0e68d-b54f-49d2-b598-f8e2f69e853b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX4vQYWR1gLTqE
 KoWZ9IDyjAaQq+wZwtcC5G0gMcuViqmF0i5NqPA8X8bVTUxXy+Gxw1aHZ5OceMldeypiCiHK1Wl
 pZm/RLOpaMlcw2EiVVnPqMm65YGtsLl23nbb0f0YJmiUnbNmXdGf1/TbbiIcGGAHdP2qtia6ZM+
 qzNhigHV4AlWtbtUgp3foCMyEVeoQsHTeUpQeE2OHPWWBpKo6iggj4Mko05QLc+4D6wZrR5geWe
 zsLa4fABlYqAiRxFlkcmmYdRKHJzC1N3T6rrvqvO5H0CT/h/xzCqWRHYbL9JWIYmfopc48EMIV6
 sIbbB/Dbq7D+7UIBssE7TA0B27vtjn+6I52PBCkCzylql1/5ogpi/iRB0O5KR0MKNtw8gqGS1zp
 BJW2KlvsnfKI2d0IA7BqbLs2NZ6RkA==
X-Proofpoint-ORIG-GUID: Xab4p2EJ5gwvk1s30wdlpXI78bp4dGob
X-Proofpoint-GUID: Xab4p2EJ5gwvk1s30wdlpXI78bp4dGob
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68dad027 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=SqMvC5kiAAAA:8 a=WpnzsXt2pHkWeAtI-ekA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3GzNa28zmJEA:10
 a=_o8VnCo6Hb5Oqlm6Mk7M:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 9/22/25 19:48, Zhuoying Cai wrote:
> On 9/18/25 4:38 AM, Daniel P. Berrangé wrote:

[...]

> 
> Thank you for the comments.
> 
> Since Secure IPL on s390x is supported in QEMU, I would like to begin
> drafting the corresponding Libvirt interface and seek feedback before
> proceeding with the implementation.
> 
> While Libvirt already provides a secure boot interface
> (https://libvirt.org/kbase/secureboot.html), it appears to be primarily
> intended for x86 systems, where secure boot is configured using the
> <firmware>, <loader>, and <nvram> tags.
> 
> 	<os firmware='efi'>
>       	    <firmware>
> 		<feature enabled='yes' name='enrolled-keys'/>
> 		<feature enabled='yes' name='secure-boot'/>
> 	    </firmware>
> 	    <loader secure='yes' type='pflash'>...</loader>
> 	    <nvram template='...'>...</nvram>
> 	</os>
> 
> For s390x, some of these existing tags may be reused, but additional
> elements will be needed.
> 
> Below is my initial proposal for the secure boot interface in Libvirt:
> 
>  	<!-- New s390-ccw-bios firmware value -->
> 	<os firmware='s390-ccw-bios'>
> 	    <type arch='s390x' machine='s390-ccw-virtio-9.2'>hvm</type>
> 	    <firmware>
>                 <!-- To enable secure boot -->
> 		<feature enabled='yes' name='secure-boot'/>
> 	    </firmware>
>             <!-- To provide boot certificates for secure boot -->
> 	    <boot-certs path='/path/to/cert.pem' />
>             <boot-certs path='/path/to/cert-dir' />
> 	    <boot dev='hd'/>
> 	</os>
> 
> I would be greatly appreciate any suggestions or feedback on this
> proposal, and I am open to refining the design to better align with
> existing Libvirt structures.
> 
> Best regards,
> Joy
> 

You should post an RFC to the libvirt list -- no code needed.  I suggest
posting what you wrote above while also giving an example of the QEMU
commandline.  Lastly, give a short background of what you've been
working on and provide a link to these patches for a more detail.

CC those who have been involved in review as well as Boris, please.  Thanks!

[...]

-- 
Regards,
  Collin


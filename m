Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36100C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 21:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtXRe-0001Ue-Dw; Mon, 10 Aug 2026 17:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wtXRc-0001U4-RM; Mon, 10 Aug 2026 17:22:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wtXRb-0006Yr-9E; Mon, 10 Aug 2026 17:22:04 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AK1foK1504645; Mon, 10 Aug 2026 21:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=r5ZqCI
 fADxtpfebRG+3ODVVpRfZPpOC5VKq3+ytBTfk=; b=Bv0TqhcQG3U+rAwKCnWazA
 dfEHcqY45vOf/YC34vm93/c+0bivkKJ63pxZ8bBv1h8UiKhEkjvpeOwzr523jopJ
 LQQJkytbcdh55aiRrBBRGLbqwmKpAOYhaMmpd3wKTia9qWgc/Us7yBhsBhMz9Geu
 RdQyAh99tz4Zsuo2rrAzynYdM7qA6ryYNiuxVYK9NFavCKMrxgwZsFEhnbxuXKHG
 xRvcpTIk2CXQblJSgLdJUWoeJebPO5eM3ys8S/b42VGU8laMfVJ0XXdsmmDVocWz
 FcgAb/RXMRRYje/Gcff3Nx4kg1YldcoVIl9ajadBvzJ0uZF8MabBVdEzaU58ZIXg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23k0uh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 21:22:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ALBIrr025710;
 Mon, 10 Aug 2026 21:22:00 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g6b85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 21:22:00 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67ALLxxC30409222
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Aug 2026 21:21:59 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 732DB58059;
 Mon, 10 Aug 2026 21:21:59 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 130A258055;
 Mon, 10 Aug 2026 21:21:59 +0000 (GMT)
Received: from [9.61.71.159] (unknown [9.61.71.159])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Aug 2026 21:21:58 +0000 (GMT)
Message-ID: <1f47fff9-34ed-48a5-aa86-adb8ae178c55@linux.ibm.com>
Date: Mon, 10 Aug 2026 17:21:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iotests/108: skip test if cannot access /dev/fuse
To: Hanna Czenczek <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260728192644.2879028-1-farman@linux.ibm.com>
 <20260728192644.2879028-2-farman@linux.ibm.com>
 <9be3c3bb-8c41-4f9b-b396-0010cce0d75e@redhat.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 xsFNBF7EiEwBEADGG0EtNKnjp+kQfEVqlqxXoBHjnaQptFpMgxNlz2GtqOujY6nzEWnybIXY
 63XUTmMS/tWUf2DTbNCNoWwumGM/I2Gj1uGyMnc4Q477BQlL/e2/9MRaut11rwHsi4zmWylc
 jO0eFTSLFA8yFBj9osT3uZzk5TwWkD8sf+rD916fFVk0G39uYEd5sjEzjeOf9/dwXyZpjJY6
 api1pUHEw7weRvOnllJAfIKFz+KoR6d7ezvMF9zOYHF73FGeSVIYoIEUhA5Cdg60rSlTtHb2
 cftex3/cEapvY5bK3CKJ33BVVK10Bht9XfVaA/AOcg/3o5ZbhSIwz4xScGsEVf/Yr368YMdr
 3VkCZrmN2ppmVRz/RvAmCyItnmzoVDlSREA6Faw6S0x8Oi7lN0cKh2hy9VPcVupraXJZrdAh
 GtdU+jrJvSbpdsrX8F7K3RwynbiqGrqC0izGla04hhtei/uwthatglukuxep4PknDGbzijg8
 Ef7A8t3qEVklUDrsnNPN5HbR9QQdeF0HuWsDTfILbZv1MICfOK3BCDeT5mJWaJCoQ2rbuljM
 e1hFSt+mr7GV4h6NcBE+uGIqDSzQORtyTo0uBV4et3cSE84JxOfXBMrj0TlL1855JaIoPWEN
 uhDRB/dHW8+Fumq2du5hLcaXPka+MO26cNVKVLF0/JjwMTZ9bQARAQABzSJFcmljIEZhcm1h
 biA8ZmFybWFuQGxpbnV4LmlibS5jb20+wsGuBBMBCABYAhsDBwsJCAcDAgEGFQgCCQoLBBYC
 AwECHgECF4AdGGh0dHBzOi8va2V5c2VydmVyLnVidW50dS5jb20WIQTSxgUEyej1aM/lh7U4
 J7IScb+VYgUCYel8TgAKCRA4J7IScb+VYsHAD/9BSQj7HeJf90PttOmVh35Bb4QyHLZ4g+9x
 waM59JCKGbiURuNRIGnoRarYXHk6vfy19v8v56Dy1IOlKWaRnizp5Mw9zXBBTCs4fgNbOzY/
 SggFY2UzcziXDG29X9zznq5LgY1Jf/cwm1O+rn89GKCZWZhLEB2wKzBj7hum7NBdW+lxfVwp
 2qONGDerttWDwAHxJ995k9aDJahq9kIKEMEZbrTQ8JI8KZGoox6+HA04EhoNzxvbV0J+/gLJ
 2DkvxN5/xmcD3z+s8B5ev3NarOF17AIA9oCdfu8CPAupcNqJW86m19P5q6AyRB2ZLyAIAAhr
 HCXrnlh/8HJW1yCOVXxprFdpg1SX1fuArjbFAh53vVVDfkZlwHeTeE7+3y1rtDLfy830pqdD
 ymv94yey2y1+iZBdbaW0fSC/JkjkOCy8oZawkH3geM4MXV4ze4gbBH6BhxW/0gbEYjnLm3FA
 53JcXwhHQFPWIYEYYPvATJi0JUiMY1Znkm3QBWDOCXSrG0tHpAclBa9L40zLRwA1h9YOMFEs
 qvKijUdvcDf4sTdJ+A6YL66grzul5vNt06NlqsI8HUDHE6vghqyWxupCav2+9b1BuLie++er
 b8OCo5n3TUHsVMjYJEePU1EkcCa84dCm+CXqPthgRv0sbe4UQEd/qUoVMdWj7Q7FL96mBn0G
 zM7BTQRexIhMARAAp+k1sC4y7Wtwjqtfu9wIihvY/Vot0v/sKg8CRGRIIRGLiCeA9o+2ZlxC
 jYztT3Leri5Vo5z09OmRMvoFLJjcHMCG5sYeZwOWNAbeuAxGkIMDSB4pLl3t2c+1PQuMBCd7
 +mRZFaMEJfT3nhdUKxy2rp1+YucnA67xGXUJCiD5l9UmhPqa7SAYlpMAqDz7cmBo25c/UNm1
 Tpwjrh70jq/4guV5gnprawH8nkRjdKH1JvKWvkuaB7FNZ9IuSHlWclcQX4IQMsaxsU2emAbP
 VYv7l4YNlKfdlJd8tuEodjuMLOBnr7e9H0hVNUWGFN9bkBNRu3zi/jvhyu15Iu4euR/WdVNu
 2K2iYxIfiGMnv0F/a6R1bm10lCJrjyf23J8DYIeH4YmHvOOqYFkq3DWOctlXbb3+aABqjYt3
 mkiOLXeplqbo/m3rWcGNd8Q/d1aVA0wm5+Nt3RdSuXG2FHOFdVUQKPLpf1NUH/LInBhS/9Ys
 ajm6tWXKv7hxwWmyz0u/th6gUra3KpARB1ypebWHULLNzKGwVS81XNs76QhXwX04cyiwLqKb
 WqLqJKThz+rLa09Ap+eO/UzPfFXvWYWfTeFRIQ/tKF332ZzRR8Xrh/fk//YXyRfpoE/7i5uz
 ve0HZWp5jXg9Yb+S6g0+XUKznnN9B8WLLCcuRIuSa722070v7KsAEQEAAcLBdgQYAQgAIAIb
 DBYhBNLGBQTJ6PVoz+WHtTgnshJxv5ViBQJh6XwwAAoJEDgnshJxv5Vib28P/1BYT5gvjuEB
 A80AXo/IqycicXxDJtrfmyw4COP7bi7AuiDcKyA1wRzC51paKwPFB8Unk2GvG4DV6aDmGTJY
 +GeCYgthQ+znW461S8B6GqDCAQt2VDNNFVU+gTuh7vYQOgt/OjtiiAvMIJBVRbXoNSRokKOF
 tpTiXf3ZOsAkot5ZmxE0TV94v18sp/bC84YvFyaxpw5bilT7bmpcq8B8/3yb0kmy6gXLcQAp
 OnomV3sQBmm050amiO3tvxMNv8J71AvNdTG/rojTDKUl2Nw4f+aw4nVw874m2XpEe9JGRw54
 5d2dN8k3GpzcTBe9fCQPOFHOGkQ1CgptDkQuQVD3DIeNzQjXf6xehEymIKnLOkukT2smV0zh
 fj08z7eiv+dsmnBsbhdM6DKU8qIgkTu77TfHUKjjOY/Mj0YHPuH/J4b1AZFxBhGP0BTKiB2W
 CR6/49XVKvY1jHxgadSSNCD+f7tEqUNBlVl+P0emMJaYpK1+gy88ma4g3nvyOVe/VzDPjGDC
 4HX/6RAR4Dbzry6/epWTTji+7ApzePzmJzPcuzD31ICsgT2dJ6ydxyxxXikBFJqx6BPOF+u+
 1BtKcTz1ek3I2sWvBM1V5CKaFw7iNXxS6HgS2scuAT2awKq+BQlt778/GfBWpXonfqixMvit
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <9be3c3bb-8c41-4f9b-b396-0010cce0d75e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7a40f9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=6rqHouBjAAAA:8
 a=VnNF1IyMAAAA:8 a=wdF1M4HB5J3ikfWXs0IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE3OCBTYWx0ZWRfX8/I2VU1fUgmJ
 fbFUF7s8npDPxHhrvMKUe6/tDhpHeXSbRCgaCyvgF5nH4Uny6evoUIdMYnUKrPt+sVZtptbhkqs
 r/N29gUGIpeEhlrGKB4cCwEQrlfrPUnhyAKZhc3eto76hQzHQFwfx8/YVuQqRv1c3HGfCB0emGZ
 1C0RzyeaytUcWg51BaEtHYJ4JPZ/7sc1aKQPVLVfrg1HGMwhafchaSHFeZ1aZnZ/XAuak6hmRlV
 hU6wOtbCSd/3wMDWJUYMiaytqgAX6+YqDho9gXu2GR69cqe1p6PHpmoGWwkWGl15gPAwYGMr1na
 1YAYAe7jTnRSgrHuJ0Pw/poW9lH6Hrqzt5F7SaqXn9GPY77CnEWoR92iCJzezob6OSpVR1JgFlt
 CQp8C3BXHd8RLnOBCTh8doMZOla7MY1uCoWT8xX/cl+5pWfvJ3gzGnECFmiQ6JvpShv5RsKfYSZ
 XVC3lg+lTSL7HNmTU5Q==
X-Proofpoint-ORIG-GUID: Cc6tv2X7WNZurJPAth0T7JRaKt1QDGi7
X-Proofpoint-GUID: Cc6tv2X7WNZurJPAth0T7JRaKt1QDGi7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE3OCBTYWx0ZWRfX2z+2B3GvNmGm
 gNWSQurcX0LsfP5qKvpcuPPIqIAWttCfDSVz8+KG8YcFMRm0JboyqvBeZayxVEP5whoWruBBh8n
 fGVCvPu4Go5p/+1o+KFIiAUwPY5cVh4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100178
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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



On 8/4/26 7:46 AM, Hanna Czenczek wrote:
> On 28.07.26 21:26, Eric Farman wrote:
>> This test might fail if the user is not root (or sudo'd):
>>
>>    fusermount3: failed to open .../scratch/qcow2-file-108/fuse-export: 
>> Permission denied
>>
>> A check exists to try to cover for this, but there are
>> two potential error messages that signal this case
>> (per the comment block associated with the check) and
>> only a skip for one of them.
>>
>> Update the common fuse check to include this message,
>> and update test 108 to utilize it.
>>
>> Fixes: 9ffd6d646d ("iotests/108: Test new refcount rebuild algorithm")
>> Based-on: <20260715103451.1930909-1-den@openvz.org>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   tests/qemu-iotests/108       | 5 +----
>>   tests/qemu-iotests/common.rc | 1 +
>>   2 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
>> index bf808b3512..5d91e58943 100755
>> --- a/tests/qemu-iotests/108
>> +++ b/tests/qemu-iotests/108
>> @@ -69,10 +69,7 @@ else
>>       # or "Invalid parameter 'fuse'", depending on whether there is
>>       # FUSE support or not.
>>       error=$($QSD --export fuse 2>&1)
>> -    if [[ $error = *"'fuse'"* ]]; then
>> -        _notrun 'Passwordless sudo for losetup or FUSE support 
>> required, but' \
>> -                'neither is available'
>> -    fi
>> +    _notrun_on_fuse_error "$error"
>>   fi
>>   echo
>> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
>> index bcb1ec50a9..844c19d15a 100644
>> --- a/tests/qemu-iotests/common.rc
>> +++ b/tests/qemu-iotests/common.rc
>> @@ -986,6 +986,7 @@ _require_drivers()
>>   _notrun_on_fuse_error()
>>   {
>>       case "$1" in
>> +        *"Parameter 'id' is missing"* | \
>>           *"Parameter 'type' does not accept value 'fuse'"*)
>>               _notrun "No FUSE support"
>>               ;;
> 
> Is “Parameter 'id' is missing” not the expected error message when there 
> *is* FUSE support? At least for the case above in test 108.
> 

Hrm, guess I got my wires crossed between a sudo-able guest and one that 
isn't. You're right that the same response is given regardless of 
whether. Let me revisit this and see if I can get this to skip properly.

Thanks,
Eric


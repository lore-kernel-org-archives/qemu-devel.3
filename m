Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222AC606A89F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GWJ83VDu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRVQI-0006no-6Z; Thu, 12 Nov 2026 09:05:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xRVPd-0006V4-Vy
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 09:04:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xRVPb-0007Tc-RR
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 09:04:25 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2iEQs2795601; Thu, 12 Nov 2026 14:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=va+2In
 KpDl+wHsJFvL6KbSrZ2VniGrvOgLz4HMSV374=; b=GWJ83VDuMACa+z5UGUmzve
 lZpVarzs2zLTo8zvuKl1JoU3ayr2VZIAvFgxbhf8ya3NfgBCNBGzTD/4jqOGmm73
 JCiETzqnD526tqy8J7bfDdVdPILS+U+EByBIjvvQ9KhSLV1nIOeSKkw5j24vtdtn
 ELBUNclmmQlITMkt7+gkIpwVMk/WyCAvJphvqTygCpKm1oOaoBgQpohk2SgQMnMB
 vzf6oa7XErzOqxvzCkZ2PygOpFS10Z91IraavICAqG5w5o7B1ry7Il6yuPoqtMtX
 1fR6Q4Cq09HPfUlrzRNkuWdDzEdRoGGZBvPnodarX+rrtk6e3g5FRTdVtDLm/WqQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkyav8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 14:04:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACCBKJN669861; Thu, 12 Nov 2026 14:04:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hwd858bnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 14:04:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6ACE4CZe27525776
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Nov 2026 14:04:12 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6347C58052;
 Thu, 12 Nov 2026 14:04:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BDAFB58056;
 Thu, 12 Nov 2026 14:04:10 +0000 (GMT)
Received: from [9.61.119.48] (unknown [9.61.119.48])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Nov 2026 14:04:10 +0000 (GMT)
Message-ID: <133cca35-7ff1-4010-9ad9-4b3e32ed3e17@linux.ibm.com>
Date: Thu, 12 Nov 2026 09:04:10 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/22] migration/cpr: forbid saving duplicate CprFds
 into hash table
To: Yi Liu <yi.l.liu@intel.com>, Omar Elghoul <oelghoul@linux.ibm.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com, mst@redhat.com,
 maciej.szmigiero@oracle.com, sgarzare@redhat.com,
 mark.kanda@oracle.com, vsementsov@yandex-team.ru, clg@redhat.com,
 den@openvz.org, dongli.zhang@oracle.com, farosas@suse.de,
 peterx@redhat.com, dwmw2@infradead.org, philmd@oss.qualcomm.com,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
 <20261012-up-vsock-vhost-v5-v16-1-36c38bd15ffc@virtuozzo.com>
 <5b08d2f3-7edc-4525-95e4-ee6719acaf5b@linux.ibm.com>
 <c9d80c86-e9e3-4b9c-8d8e-5f4e0ed603a9@linux.ibm.com>
 <df977bf7-c951-49b2-a44e-7954373a0a93@linux.ibm.com>
 <15c2a971-97fb-4d69-85cd-24f3251588d2@intel.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <15c2a971-97fb-4d69-85cd-24f3251588d2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af5c75f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=A3H8OfN2AAAA:8
 a=20KFwNOVAAAA:8 a=TYBLyS7eAAAA:8 a=p5WsLqEfDn5TyHnmNUsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=hKFNpMRl0UUYlmJlzFdh:22 a=zvYvwCWiE4KgVXXeO06c:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfXxq49o8X/Smra
 pojO9AssolrQbvBhXs+bGpZMZkKNI1mLcidZ9ZwJltLFy1Dsir4Wd5tkqlLnDtDA1aYnyQ+Y/ej
 Kkdj8f12hybydZmhCcwpuN69d4RJdiog4ZdeJ1uaD2GHhBIvqg2c+yDCLGlY6O9RgEDq0oWeR8R
 oy/t7LY3+XkItLJEPB788cvoWdA0kVSNF91XltgXnUzRwrb5NKylAjMrNEkkqFoI4FWHhzguuDI
 CiVtQNZXZdFZCVR5lz8b3XVr+NqiLVqtEg03e25WmeGkeTFfT8vPG/4NZuEl82rDNZRkWOy7FXS
 n6GWqhEoDUTkWYAJeXPlJpotzhhlaCB/DR+ri61XqLzHotMMhCwitV12TqcrVjJD5UVLymh0Bh1
 F878DC7sMKWOgpEEqZBAH/YUjyn5oNFGeV3kzLKY9sottdYfhOtnYDB144y8zm5bfzaEC1twFuO
 yOkSpvgxEVs0pqVLaKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX3nDmEBr32ghj
 vxAzYtYgN/KzgyOi3vHJzSfb+OeuyW9c/1q+viSq3vQ2lQm0SUsbNOHsrF9+3HCpP/D5MHBymSS
 XONH0OosVAXrIvrY2BmLlKcS25T+Sms=
X-Proofpoint-ORIG-GUID: GfUpMQrLkFS9Ayf1unrZh5_F19KYh6Yi
X-Proofpoint-GUID: GfUpMQrLkFS9Ayf1unrZh5_F19KYh6Yi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120054
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/12/26 3:58 AM, Yi Liu wrote:
> On 11/12/26 13:04, Eric Farman wrote:
>>
>> +cc iommufd maintainers
>>
>> On 11/11/26 11:52 PM, Eric Farman wrote:
>>>
>>>
>>> On 11/10/26 3:51 PM, Omar Elghoul wrote:
>>>> On 10/12/26 6:28 AM, Andrey Drobyshev wrote:
>>>>> In its current form, the mechanism for saving CPR FDs into hash table
>>>>> has flaws.
>>>>>
>>>>> The CPR fd hash table uses the same CprFd for both key and value, and
>>>>> is created with a key destroy function.  Inserting a second element
>>>>> with the same (name, id) key leads to a use after free.  According to
>>>>> GLib docs [1], g_hash_table_insert() keeps the old key, replaces the
>>>>> value with the new element, and destroys the new key.  Thus when
>>>>> inserting 2 CprFd elements fd1 and fd2 with equal keys we get:
>>>>>
>>>>>    g_hash_table_insert(table, fd1, fd1);  /* table has fd1 -> fd1 */
>>>>>    g_hash_table_insert(table, fd2, fd2);  /* table has fd1 -> fd2, 
>>>>> fd2 freed */
>>>>>
>>>>> Any subsequent cpr_find_fd() for that key then returns freed memory.
>>>>>
>>>>> This is reachable whenever two CPR-aware objects register fds under 
>>>>> the
>>>>> same name, and it happens long before an actual CPR, since 
>>>>> cpr_save_fd()
>>>>> is typically called from .realize(), i.e. at boot time.
>>>>>
>>>>> Apart from the UAF itself, when the user decides to perform CPR 
>>>>> migration,
>>>>> on CPR target we'd get corrupted FD from the hash table and fail 
>>>>> somewhere
>>>>> in .realize() for affected devices.
>>>>>
>>>>> As a solution, let's altogether prohibit adding CprFds with duplicate
>>>>> keys.  Since FDs are being registered for a subsequent CPR right at 
>>>>> the
>>>>> startup in .realize(), that'll allow us to error out and exit QEMU (or
>>>>> fail a device hotplug op) gracefully instead of delaying potential
>>>>> problems for later.  To do so, let's make cpr_save_fd() return 'bool'
>>>>> instead of 'void' and provide an 'errp' argument to it.  That way 
>>>>> caller
>>>>> becomes responsible for checking the return value and propagating the
>>>>> error.
>>>>>
>>>>> Also update all the callers to use the adjusted interface to keep 
>>>>> things
>>>>> compilable and bisectable.
>>>>>
>>>>> [1] https://docs.gtk.org/glib/type_func.HashTable.insert.html
>>>>>
>>>>> Fixes: a181df93bb3 ("migration/cpr: use hashtable for cpr fds")
>>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>>
>>>> Hi everyone, FYI we've recently run into a regression on s390x where if
>>>> we have a KVM guest with a PCI passthrough device using iommufd and we
>>>> hot-unplug the device, the guest becomes fully unresponsive. In the 
>>>> host
>>>> dmesg, we can see this message right when the hang begins:
>>>>
>>>> [ 1618.849602] vfio-pci 0001:00:00.0: No device request channel
>>>> registered, blocked until released by user
>>>
>>> It's worth pointing out that the new error message in this commit 
>>> does indeed show up in the logs, and points to the problematic device 
>>> fd:
>>>
>>> virtqemud[1172]: internal error: unable to execute QEMU command 
>>> 'object- add': cpr fd 'iommufd0' id 0 is already registered
>>> virtqemud[1172]: internal error: unable to execute QEMU command 
>>> 'closefd': File descriptor named 'iommufd' not found
>>> kernel: mlx5_vfio_pci 0004:00:00.0: No device request channel 
>>> registered, blocked until released by user
>>>
>>>
>>>>
>>>> Bisecting qemu leads us to this patch:
>>>>
>>>> de80025348925ba9f56070ce4ec0a5a0c512d450 is the first 'bad' commit
>>>> commit de80025348925ba9f56070ce4ec0a5a0c512d450
>>>> Author: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>> Date:   Mon Oct 12 13:28:09 2026 +0300
>>>>
>>>>      migration/cpr: forbid saving duplicate CprFds into hash table
>>>>
>>>> We tried to revert the commit to confirm the root cause, but then the
>>>> master branch no longer compiles, so unfortunately we were not able to
>>>> confirm that, at least without making many changes.
>>>>
>>>> We're wondering if you might have any ideas what's going on there, or
>>>> what we could do to try and resolve this issue. Any thoughts would be
>>>> much appreciated and I'd be happy to share more info if needed.
>>>
>>>
>>> Since the routine that unregisters such an fd is cpr_delete_fd(), but 
>>> that gets skipped as soon as we go through the _set_fd() path, I 
>>> wonder if the solution starts as something like the following?
>>>
>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>> index ecf4caee1a..d708948357 100644
>>> --- a/backends/iommufd.c
>>> +++ b/backends/iommufd.c
>>> @@ -161,8 +161,8 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be)
>>>       be->users--;
>>>       if (!be->users) {
>>>           vfio_iommufd_cpr_unregister_iommufd(be);
>>> +        cpr_delete_fd(iommufd_fd_name(be), 0);
>>>           if (be->owned) {
>>> -            cpr_delete_fd(iommufd_fd_name(be), 0);
>>>               close(be->fd);
>>>               be->fd = -1;
>>>           }
>>>
>>> What that means for the prepare_delete/finalize paths and/or the 
>>> failure path in _connect is something else to ponder... Neither of 
>>> those call cpr_delete_fd() themselves despite closing the fd if it 
>>> owns the thing.
> 
> Hi Eric,
> 
> Agreed the iommufd0 duplicate-key error is real and your analysis is
> self-consistent. One thought on the fix placement though:
> 
> iommufd_backend_disconnect()'s existing if (be->owned) guard around
> cpr_delete_fd() mirrors the save side in connect() (be->owned && !be- 
>  >users), both tied to be->users - that pairing is fine as-is. The actual
> asymmetry is that for !be->owned backends, the save happens
> unconditionally in complete(). So the matching delete seems like it
> should go in finalize()/prepare_delete() instead.

Hi Yi Liu,

Thanks for the info. I had talked myself out of the 
finalize/prepare_delete path because of the owned/!owned thing, but that 
was mostly my unfamiliarity with this code to start with. I agree with 
your reasoning, and moving this outside of the guard isn't the right 
thing here.

> 
> The below hunk of commit de8002534892 indeed can result in req_trigger
> being null. But I haven't yet figured out how the error path would be
> triggered in that case.

Yeah, I don't know either, was just looking at how this fd gets 
set/freed once I got this scenario to start working again. I'll mess 
around with this today, and see if I can get a patch on the list for -rc1.

Thanks!
Eric

> 
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -76,7 +76,10 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, 
> EventNotifier *e,
>       }
> 
>       fd = event_notifier_get_fd(e);
> -    vfio_cpr_save_vector_fd(vdev, name, nr, fd);
> +    if (!vfio_cpr_save_vector_fd(vdev, name, nr, fd, errp)) {
> +        event_notifier_cleanup(e);
> +        return false;
> +    }
>       return true;
>   }
> 
> 
> Regards,
> Yi Liu



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE26606A886
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NvuE3vzt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRMoE-0003rG-AU; Wed, 11 Nov 2026 23:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xRMo8-0003qb-FZ
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 23:53:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xRMo6-0001KJ-EK
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 23:53:08 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2jQjL1640426; Thu, 12 Nov 2026 04:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Ft4s9V
 b3JQe4qIpQ4RD+K7zX7HEuzLtSmQqCnSizwZg=; b=NvuE3vztDaypz23NLIKOBP
 le0G2oMBjQFk8tsMWMaV/bFKDlwOsv/R4eNnenPbn3fyLr9rJPvchOI7DmUz/eo9
 mJLyOxNHYsmeim+psys2YiXiW+Pmf+eRkrK2TMd5/QKpAH1vZbc8/mhjdvKCkaoV
 1uFqBQ+Hd34IIiVlCFdcXkrW0fes12Q3wCYsJh5YdrJ5cFGZbXomObJilkncI2R4
 uKxXh29g7bTA6+xU87OXHbNDMA3h+lHY+Lrl8xWW9dDRw10k0zmwJgCYaQ8We7KN
 ilQX8rQIGx8Koe0DlwhOkjHQF8Y4f1IbZ3gNBNJBRb6oAmU9SKHIBB7nzCZtvSkQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdgcuv7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 04:52:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2a76G3146060; Thu, 12 Nov 2026 04:52:55 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd51w2bw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 04:52:55 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AC4qrRv28181136
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Nov 2026 04:52:54 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D56A5805B;
 Thu, 12 Nov 2026 04:52:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A18F358059;
 Thu, 12 Nov 2026 04:52:51 +0000 (GMT)
Received: from [9.61.119.48] (unknown [9.61.119.48])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Nov 2026 04:52:51 +0000 (GMT)
Message-ID: <c9d80c86-e9e3-4b9c-8d8e-5f4e0ed603a9@linux.ibm.com>
Date: Wed, 11 Nov 2026 23:52:51 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/22] migration/cpr: forbid saving duplicate CprFds
 into hash table
To: Omar Elghoul <oelghoul@linux.ibm.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com, mst@redhat.com,
 maciej.szmigiero@oracle.com, sgarzare@redhat.com,
 mark.kanda@oracle.com, vsementsov@yandex-team.ru, clg@redhat.com,
 den@openvz.org, dongli.zhang@oracle.com, farosas@suse.de,
 peterx@redhat.com, dwmw2@infradead.org, philmd@oss.qualcomm.com,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
 <20261012-up-vsock-vhost-v5-v16-1-36c38bd15ffc@virtuozzo.com>
 <5b08d2f3-7edc-4525-95e4-ee6719acaf5b@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <5b08d2f3-7edc-4525-95e4-ee6719acaf5b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af54628 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=A3H8OfN2AAAA:8
 a=20KFwNOVAAAA:8 a=TYBLyS7eAAAA:8 a=KRh0FhJCEkQDcsi_NIAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=hKFNpMRl0UUYlmJlzFdh:22 a=zvYvwCWiE4KgVXXeO06c:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAxOCBTYWx0ZWRfX9SFZoxlCJCBg
 LKnUV5JHTxK95T0LBxoaaSeuO3QEVRbqz5MI2JGqcHTftH2skUQYQesKpw9kgHAksjBJeGYsVL8
 Jhuvft59vX8vO1KAiCikyfAcPk7/m1ztFHjKPKJrwQgENhCawLBbj1IX9SebCgynpB1N/oDQmNT
 Kc8na6RWRiuTnFtY56HnKfZZRpkBsctGpghKaA9XxhdDZ1G2AywLJkEXOrmrdBuFu4BzX3rb/gM
 iwtFlGl+R5hUmE2aDEcyjLHnefsb/9Lu8miXKIvmnf/hJBxBCLW1HokbPOuveA8aZeHotSyUaQb
 o0o7ZRRNAUZJY6muzW6Az8jwBsgvfpk0G4ToViKYd5AqDlSIzfrp/MlA8gdVzjFil4CtqI49iEM
 GxA4LGb1ZsW1FxHwyD9HafpnxICbKHXhJiO/2+7V53o6bEt3RhweqeZiqLOQ0s0hff6EOUFvWUc
 GsU8GC4GZEsxhYpP1Hg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAxOCBTYWx0ZWRfX19NtzFmwR9KI
 RrCDjEb4Hdq9bexjpHVun4G8DiWwRuBJ6vXL8+yu8smFIVwpqYn1OdUyWRjBwr2SFLXfMmvrrTZ
 +ueHwOpThMIKb66Xop/JkP8iPRR7xxE=
X-Proofpoint-GUID: XvjVUwdElhZELYiCCOSc8CLmibT-7paa
X-Proofpoint-ORIG-GUID: XvjVUwdElhZELYiCCOSc8CLmibT-7paa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120018
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/10/26 3:51 PM, Omar Elghoul wrote:
> On 10/12/26 6:28 AM, Andrey Drobyshev wrote:
>> In its current form, the mechanism for saving CPR FDs into hash table
>> has flaws.
>>
>> The CPR fd hash table uses the same CprFd for both key and value, and
>> is created with a key destroy function.  Inserting a second element
>> with the same (name, id) key leads to a use after free.  According to
>> GLib docs [1], g_hash_table_insert() keeps the old key, replaces the
>> value with the new element, and destroys the new key.  Thus when
>> inserting 2 CprFd elements fd1 and fd2 with equal keys we get:
>>
>>    g_hash_table_insert(table, fd1, fd1);  /* table has fd1 -> fd1 */
>>    g_hash_table_insert(table, fd2, fd2);  /* table has fd1 -> fd2, fd2 
>> freed */
>>
>> Any subsequent cpr_find_fd() for that key then returns freed memory.
>>
>> This is reachable whenever two CPR-aware objects register fds under the
>> same name, and it happens long before an actual CPR, since cpr_save_fd()
>> is typically called from .realize(), i.e. at boot time.
>>
>> Apart from the UAF itself, when the user decides to perform CPR 
>> migration,
>> on CPR target we'd get corrupted FD from the hash table and fail 
>> somewhere
>> in .realize() for affected devices.
>>
>> As a solution, let's altogether prohibit adding CprFds with duplicate
>> keys.  Since FDs are being registered for a subsequent CPR right at the
>> startup in .realize(), that'll allow us to error out and exit QEMU (or
>> fail a device hotplug op) gracefully instead of delaying potential
>> problems for later.  To do so, let's make cpr_save_fd() return 'bool'
>> instead of 'void' and provide an 'errp' argument to it.  That way caller
>> becomes responsible for checking the return value and propagating the
>> error.
>>
>> Also update all the callers to use the adjusted interface to keep things
>> compilable and bisectable.
>>
>> [1] https://docs.gtk.org/glib/type_func.HashTable.insert.html
>>
>> Fixes: a181df93bb3 ("migration/cpr: use hashtable for cpr fds")
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> Hi everyone, FYI we've recently run into a regression on s390x where if
> we have a KVM guest with a PCI passthrough device using iommufd and we
> hot-unplug the device, the guest becomes fully unresponsive. In the host
> dmesg, we can see this message right when the hang begins:
> 
> [ 1618.849602] vfio-pci 0001:00:00.0: No device request channel
> registered, blocked until released by user

It's worth pointing out that the new error message in this commit does 
indeed show up in the logs, and points to the problematic device fd:

virtqemud[1172]: internal error: unable to execute QEMU command 
'object-add': cpr fd 'iommufd0' id 0 is already registered
virtqemud[1172]: internal error: unable to execute QEMU command 
'closefd': File descriptor named 'iommufd' not found
kernel: mlx5_vfio_pci 0004:00:00.0: No device request channel 
registered, blocked until released by user


> 
> Bisecting qemu leads us to this patch:
> 
> de80025348925ba9f56070ce4ec0a5a0c512d450 is the first 'bad' commit
> commit de80025348925ba9f56070ce4ec0a5a0c512d450
> Author: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Date:   Mon Oct 12 13:28:09 2026 +0300
> 
>      migration/cpr: forbid saving duplicate CprFds into hash table
> 
> We tried to revert the commit to confirm the root cause, but then the
> master branch no longer compiles, so unfortunately we were not able to
> confirm that, at least without making many changes.
> 
> We're wondering if you might have any ideas what's going on there, or
> what we could do to try and resolve this issue. Any thoughts would be
> much appreciated and I'd be happy to share more info if needed.


Since the routine that unregisters such an fd is cpr_delete_fd(), but 
that gets skipped as soon as we go through the _set_fd() path, I wonder 
if the solution starts as something like the following?

diff --git a/backends/iommufd.c b/backends/iommufd.c
index ecf4caee1a..d708948357 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -161,8 +161,8 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be)
      be->users--;
      if (!be->users) {
          vfio_iommufd_cpr_unregister_iommufd(be);
+        cpr_delete_fd(iommufd_fd_name(be), 0);
          if (be->owned) {
-            cpr_delete_fd(iommufd_fd_name(be), 0);
              close(be->fd);
              be->fd = -1;
          }

What that means for the prepare_delete/finalize paths and/or the failure 
path in _connect is something else to ponder... Neither of those call 
cpr_delete_fd() themselves despite closing the fd if it owns the thing.

> 
> Thanks in advance!
> 
> [...]



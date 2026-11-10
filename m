Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2C7606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 20:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HhX6Sh5v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQsp4-0004p5-D2; Tue, 10 Nov 2026 15:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1xQsoy-0004mT-RH
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 15:52:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1xQsow-0007V4-Nn
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 15:52:00 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAJEBaf1947333; Tue, 10 Nov 2026 20:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=p3puUx
 zY6YGe1TNxtQYMDNJN2lWyYaz3hcXsBw8hBjs=; b=HhX6Sh5vO2LEWUGJZUTSGq
 6MyQZjif0oFDXJ7HEkNwqlPQnSUQWXnotejg4Dsbetl3vo3wTVKUiMD8g/gp5sTU
 e41m8wZ2CwQq9cKh8eILKRF1hx06Ltf72qe+htbZdevIuhycOsarLgtklamHCBIR
 ESx84VrJTs2wm7Fw46U5KvEFjQA1k9nJ7WNKjm4hEscM87272kTBppzq4GN3WSDX
 k51z/ySjFjuu7q/w1IwVErHi1xTWFKwTFDhe7B1r43iqsmvxwUS3Z+4lmZXYbGWg
 lntHzou12BI4dRocuD7t7SldwaSD/wp9gzgzlYb4HQFdSRrSXnUHE8RP84Z4t5ig
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdg6grm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 10 Nov 2026 20:51:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAIq0Lp2180975; Tue, 10 Nov 2026 20:51:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv309hrps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Nov 2026 20:51:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AAKpeaU11272788
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Nov 2026 20:51:40 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6455B58052;
 Tue, 10 Nov 2026 20:51:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E4725805E;
 Tue, 10 Nov 2026 20:51:38 +0000 (GMT)
Received: from [9.61.251.49] (unknown [9.61.251.49])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 10 Nov 2026 20:51:38 +0000 (GMT)
Message-ID: <5b08d2f3-7edc-4525-95e4-ee6719acaf5b@linux.ibm.com>
Date: Tue, 10 Nov 2026 15:51:36 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/22] migration/cpr: forbid saving duplicate CprFds
 into hash table
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com, mst@redhat.com,
 maciej.szmigiero@oracle.com, sgarzare@redhat.com,
 mark.kanda@oracle.com, vsementsov@yandex-team.ru, clg@redhat.com,
 den@openvz.org, dongli.zhang@oracle.com, farosas@suse.de,
 peterx@redhat.com, dwmw2@infradead.org, philmd@oss.qualcomm.com,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 farman@linux.ibm.com, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
 <20261012-up-vsock-vhost-v5-v16-1-36c38bd15ffc@virtuozzo.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <20261012-up-vsock-vhost-v5-v16-1-36c38bd15ffc@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af383df cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=A3H8OfN2AAAA:8
 a=20KFwNOVAAAA:8 a=TYBLyS7eAAAA:8 a=MMkEkiIHCQ59v8og694A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=hKFNpMRl0UUYlmJlzFdh:22 a=zvYvwCWiE4KgVXXeO06c:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA4MiBTYWx0ZWRfXyJBDJ2j4wu8R
 3epqXrl32B2huaaRkC7fW7O4RengNBCMeS/PYK9OIhMIGvksoenTwZvbjUwZdJ1AvnZKqbsd+PK
 zBhIOF1+DdvjSGL2NYKGzOSCQTl1j5z6geiztvt1hQ8UQZIB8D4DpGFrPVk+lbruoiKExXBl28q
 d3lzrvstdx/zp7H1/rEFkGuZXeompqlucW1QsfZNn3mV9dh8A1X7ud+ZfM9Qem3vz7zzzKFdIAu
 TyuPp6PhKhXly/lxQL9CNb6pRj/kf1TN9E8QuM8OJY63UyM0pwxDQK76z/I//wWdaVVIaXW3r34
 ymDmCgTsN5ba6Ni139+vq5JIZen4SzX0kKkqfYFsDEvQhR9rYyHXnbFkIW1tzR7RwomrJb5SgmV
 YB5PJ+lx/kMji/oB4tlMwQdtw+VOsts5FiVlukgfk2HbY7E4QaDmp7KyCQtvhNIQMYV6iWWyyAq
 xtVR0aN1B10lZ00aR+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA4MiBTYWx0ZWRfX72czpU2unwB1
 GLzCBAQ+hPswhA/n9wmHvK0ecARul9z7mNavy29Zsby0yFfyZG6kX9AEBxdkJYleXCWBI7AMool
 EPBK+zFFOM7zwRNxmIPlfyxBlSunG/Q=
X-Proofpoint-GUID: EIyW3619CkEc2We4wM2CB_-5ceeTgODM
X-Proofpoint-ORIG-GUID: EIyW3619CkEc2We4wM2CB_-5ceeTgODM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100082
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=oelghoul@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/12/26 6:28 AM, Andrey Drobyshev wrote:
> In its current form, the mechanism for saving CPR FDs into hash table
> has flaws.
> 
> The CPR fd hash table uses the same CprFd for both key and value, and
> is created with a key destroy function.  Inserting a second element
> with the same (name, id) key leads to a use after free.  According to
> GLib docs [1], g_hash_table_insert() keeps the old key, replaces the
> value with the new element, and destroys the new key.  Thus when
> inserting 2 CprFd elements fd1 and fd2 with equal keys we get:
> 
>    g_hash_table_insert(table, fd1, fd1);  /* table has fd1 -> fd1 */
>    g_hash_table_insert(table, fd2, fd2);  /* table has fd1 -> fd2, fd2 freed */
> 
> Any subsequent cpr_find_fd() for that key then returns freed memory.
> 
> This is reachable whenever two CPR-aware objects register fds under the
> same name, and it happens long before an actual CPR, since cpr_save_fd()
> is typically called from .realize(), i.e. at boot time.
> 
> Apart from the UAF itself, when the user decides to perform CPR migration,
> on CPR target we'd get corrupted FD from the hash table and fail somewhere
> in .realize() for affected devices.
> 
> As a solution, let's altogether prohibit adding CprFds with duplicate
> keys.  Since FDs are being registered for a subsequent CPR right at the
> startup in .realize(), that'll allow us to error out and exit QEMU (or
> fail a device hotplug op) gracefully instead of delaying potential
> problems for later.  To do so, let's make cpr_save_fd() return 'bool'
> instead of 'void' and provide an 'errp' argument to it.  That way caller
> becomes responsible for checking the return value and propagating the
> error.
> 
> Also update all the callers to use the adjusted interface to keep things
> compilable and bisectable.
> 
> [1] https://docs.gtk.org/glib/type_func.HashTable.insert.html
> 
> Fixes: a181df93bb3 ("migration/cpr: use hashtable for cpr fds")
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Hi everyone, FYI we've recently run into a regression on s390x where if
we have a KVM guest with a PCI passthrough device using iommufd and we
hot-unplug the device, the guest becomes fully unresponsive. In the host
dmesg, we can see this message right when the hang begins:

[ 1618.849602] vfio-pci 0001:00:00.0: No device request channel
registered, blocked until released by user

Bisecting qemu leads us to this patch:

de80025348925ba9f56070ce4ec0a5a0c512d450 is the first 'bad' commit
commit de80025348925ba9f56070ce4ec0a5a0c512d450
Author: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date:   Mon Oct 12 13:28:09 2026 +0300

     migration/cpr: forbid saving duplicate CprFds into hash table

We tried to revert the commit to confirm the root cause, but then the
master branch no longer compiles, so unfortunately we were not able to
confirm that, at least without making many changes.

We're wondering if you might have any ideas what's going on there, or
what we could do to try and resolve this issue. Any thoughts would be
much appreciated and I'd be happy to share more info if needed.

Thanks in advance!

[...]




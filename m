Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47E4C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 17:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTlOP-0005fs-S9; Mon, 23 Jun 2025 13:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1uTlON-0005fe-5P
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 13:55:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1uTlOK-0002I0-PG
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 13:55:38 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NGU79f025695;
 Mon, 23 Jun 2025 17:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Rsx21n
 LCfQc7Y795lacGxwmeztx5pYhEMDk8lZrOryk=; b=EtkMTOpJWO9qf3v9r3CuqS
 E7VqQ4mG/UgsjIt3eRACL75AsIHdMfDPxR8z+Q4PpEl8wGMl78rmkl+KKPCuZF4K
 s5MxwXhqm4ga3SgjBJ2s5T4ZEBf0jzPwj/lvd5/jRhptSaQneXNG5bc6xCKVuadN
 tERZ3oPCKjOt2eJmgrs8OjXchElf/qlVjeC1E7G1ZTn+iVLU9ehrre8CwCOQWV9t
 tDiAHgmPkE6xlv9nq1e2F8K+Y0tIRUKP/6s1f2OyA8/Xj3Nm1D6hEqqg6vsBVR5x
 JtNN8MV8H6XVlbiOCXdu09y0gjbZLel1dgKa6gHQTKjIUMLnTVAUeXQWQkb6foYw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8j3ta3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 17:55:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NF7CfK014748;
 Mon, 23 Jun 2025 17:55:32 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s27qra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 17:55:32 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55NHtWZK28508842
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Jun 2025 17:55:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBE995805B;
 Mon, 23 Jun 2025 17:55:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F00A658058;
 Mon, 23 Jun 2025 17:55:29 +0000 (GMT)
Received: from [9.61.246.2] (unknown [9.61.246.2])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Jun 2025 17:55:29 +0000 (GMT)
Message-ID: <657a0179-c51f-4e26-9ade-a0efbed732bb@linux.ibm.com>
Date: Mon, 23 Jun 2025 23:25:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: virsh migrate fails when --copy-storage-all option is given!
To: Peter Krempa <pkrempa@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, farosas@suse.de,
 devel@lists.libvirt.org
References: <31711771-7caa-4ea3-b763-45db6930e28e@linux.ibm.com>
 <aDctC8i7U2J5bmyw@x1.local> <aEA_EtAKVnk0oYej@redhat.com>
 <aEBJxUIYRaOKBiCL@angien.pipo.sk>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <aEBJxUIYRaOKBiCL@angien.pipo.sk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDExMCBTYWx0ZWRfX0kqrZw02yyue
 9cdRY5eS0khFmkCpSnQmS2j5Nl7tXeyqlOoJt8Ci3wS0BKPxju0Li6ad8vrbRzi+3WV7xN7gONX
 xbFmDhwDZxuv7ycn7sh1aoDbLbx9CPNUEtIVAnowkWCvm7a77Hs15ZXZoaHEaMSE/5J4m57fbYT
 Srz12wLmYHDO1UHqIf7+oCJlSCnf9B0qGUXlxyi9QWVeSs9U9mKhS7vHAEogTTvmau1w8RdDNbY
 lnkC9zZwnFJX24xEUvLE/L3Wh9xGQmILKbjlgTUpBOpGndizyXe99DZNV0Ua9DnxIJdYtG08xF5
 DgaE910HswQ9wMYELosenJJZMakc9PRf/3bQY+cdDvWM+XC/Z/YjorQuVAsH3SmgxwkEP662Lu8
 soFc+KCxOcXDU2FlSMOLbdAiFa8ss4Dk4gG9UtQ1ikesEvLBLC/84tHZSemqRatSTpyWA3eO
X-Proofpoint-GUID: DubDgxQnFJp1dTaQ5XjCWhRI2w3u9ZRg
X-Proofpoint-ORIG-GUID: DubDgxQnFJp1dTaQ5XjCWhRI2w3u9ZRg
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=68599515 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=SqMvC5kiAAAA:8 a=VwQbUJbxAAAA:8
 a=mu_pSlw8ttt8Xw8YjK4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ISsoRvfnYWsA:10 a=8sT2JCJfbWsA:10
 a=_o8VnCo6Hb5Oqlm6Mk7M:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230110
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=anushree.mathur@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

CC: libvirt devel list

Hi Kevin/Peter,

Thank you so much for addressing this issue. I tried out few more things and
here is my analysis:

Even when I removed the readonly option from guest xml I was still seeing the
issue in migration,In the qemu-commandline I could still see auto-read-only
option being set as true by default.

Then I tried giving the auto-read-only as false in the guest xml with
qemu-commandline param, it was actually getting set to false and the migration
worked!


Steps I tried:

1) Started the guest with adding the snippet in the guest xml with parameters
as:

   <qemu:commandline>
     <qemu:arg value='-blockdev'/>
     <qemu:arg value='driver=file,filename=/disk_nfs/nfs/migrate_root.qcow2,node-name=drivefile,auto-read-only=false'/>
     <qemu:arg value='-blockdev'/>
     <qemu:arg value='driver=qcow2,file=drivefile,node-name=drive0'/>
     <qemu:arg value='-device'/>
     <qemu:arg value='virtio-blk-pci,drive=drive0,id=virtio-disk0,bus=pci.0,addr=0x5'/>
   </qemu:commandline>

2) Started the migration and it worked.

Could anyone please clarify from libvirt side what is the change required?

Thanks,
Anushree-Mathur


On 04/06/25 6:57 PM, Peter Krempa wrote:
> On Wed, Jun 04, 2025 at 14:41:54 +0200, Kevin Wolf wrote:
>> Am 28.05.2025 um 17:34 hat Peter Xu geschrieben:
>>> Copy Kevin.
>>>
>>> On Wed, May 28, 2025 at 07:21:12PM +0530, Anushree Mathur wrote:
>>>> Hi all,
>>>>
>>>>
>>>> When I am trying to migrate the guest from host1 to host2 with the command
>>>> line as follows:
>>>>
>>>> date;virsh migrate --live --domain guest1 qemu+ssh://dest/system --verbose
>>>> --undefinesource --persistent --auto-converge --postcopy
>>>> --copy-storage-all;date
>>>>
>>>> and it fails with the following error message-
>>>>
>>>> error: internal error: unable to execute QEMU command 'block-export-add':
>>>> Block node is read-only
>>>>
>>>> HOST ENV:
>>>>
>>>> qemu : QEMU emulator version 9.2.2
>>>> libvirt : libvirtd (libvirt) 11.1.0
>>>> Seen with upstream qemu also
>>>>
>>>> Steps to reproduce:
>>>> 1) Start the guest1
>>>> 2) Migrate it with the command as
>>>>
>>>> date;virsh migrate --live --domain guest1 qemu+ssh://dest/system --verbose
>>>> --undefinesource --persistent --auto-converge --postcopy
>>>> --copy-storage-all;date
>>>>
>>>> 3) It fails as follows:
>>>> error: internal error: unable to execute QEMU command 'block-export-add':
>>>> Block node is read-only
>> I assume this is about an inactive block node. Probably on the
>> destination, but that's not clear to me from the error message.
> Yes this would be on the destination. Libvirt exports the nodes on
> destination, source connects and does the blockjob.
>
> The destination side is configured the same way as the source side so
> if the source disk is configured as read-write the destination should be
> as well
>
>>>> Things I analyzed-
>>>> 1) This issue is not happening if I give --unsafe option in the virsh
>>>> migrate command
> This is weird; this shouldn't have any impact.
>
>> What does this translate to on the QEMU command line?
>>
>>>> 2) O/P of qemu-monitor command also shows ro as false
>>>>
>>>> virsh qemu-monitor-command guest1 --pretty --cmd '{ "execute": "query-block"
> it'd be impossible to execute this on the guest due to timing; you'll
> need to collect libvirt debug logs to do that:
>
> https://www.libvirt.org/kbase/debuglogs.html#tl-dr-enable-debug-logs-for-most-common-scenario
>
> I also thing this should be eventually filed in a
>
>>>> }'
>>>> {
>>>>    "return": [
>>>>      {
>>>>        "io-status": "ok",
>>>>        "device": "",
>>>>        "locked": false,
>>>>        "removable": false,
>>>>        "inserted": {
>>>>          "iops_rd": 0,
>>>>          "detect_zeroes": "off",
>>>>          "image": {
>>>>            "virtual-size": 21474836480,
>>>>            "filename": "/home/Anu/guest_anu.qcow2",
>>>>            "cluster-size": 65536,
>>>>            "format": "qcow2",
>>>>            "actual-size": 5226561536,
>>>>            "format-specific": {
>>>>              "type": "qcow2",
>>>>              "data": {
>>>>                "compat": "1.1",
>>>>                "compression-type": "zlib",
>>>>                "lazy-refcounts": false,
>>>>                "refcount-bits": 16,
>>>>                "corrupt": false,
>>>>                "extended-l2": false
>>>>              }
>>>>            },
>>>>            "dirty-flag": false
>>>>          },
>>>>          "iops_wr": 0,
>>>>          "ro": false,
>>>>          "node-name": "libvirt-1-format",
>>>>          "backing_file_depth": 0,
>>>>          "drv": "qcow2",
>>>>          "iops": 0,
>>>>          "bps_wr": 0,
>>>>          "write_threshold": 0,
>>>>          "encrypted": false,
>>>>          "bps": 0,
>>>>          "bps_rd": 0,
>>>>          "cache": {
>>>>            "no-flush": false,
>>>>            "direct": false,
>>>>            "writeback": true
>>>>          },
>>>>          "file": "/home/Anu/guest_anu.qcow2"
>>>>        },
>>>>        "qdev": "/machine/peripheral/virtio-disk0/virtio-backend",
>>>>        "type": "unknown"
>>>>      }
>>>>    ],
>>>>    "id": "libvirt-26"
>>>> }
>> I assume this is still from the source where the image is still active.
> Yes; on the destination the process wouldn't be around long enough to
> call 'virsh qemu-monitor-command'
>
>> Also it doesn't contain the "active" field yet that was recently
>> introduced, which could show something about this. I believe you would
>> still get "read-only": false for an inactive image if it's supposed to
>> be read-write after the migration completes.
>>
>>>> 3) Guest doesn't have any readonly
>>>>
>>>> virsh dumpxml guest1 | grep readonly
>>>>
>>>> 4) Tried giving the proper permissions also
>>>>
>>>> -rwxrwxrwx. 1 qemu qemu 4.9G Apr 28 15:06 guest_anu.qcow
> Is this on the destination? did you pre-create it yourself? otherwise
> libvirt is pre-creating that image for-non-shared-storage migration
> (--copy-storage-all) which should have proper permissions when it's
> created
>
>>>> 5) Checked for the permission of the pool also that is also proper!
>>>>
>>>> 6) Found 1 older bug similar to this, pasting the link for reference:
>>>>
>>>>
>>>> https://patchwork.kernel.org/project/qemu-devel/patch/20170811164854.GG4162@localhost.localdomain/
>> What's happening in detail is more of a virsh/libvirt question. CCing
>> Peter Krempa, he might have an idea.
> Please collect the debug log; at least from the destination side of
> migration. That should show  how the VM is prepared and qemu invoked.
>



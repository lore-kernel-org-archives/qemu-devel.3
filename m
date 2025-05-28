Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAEBC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 13:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKHBm-00020M-LM; Wed, 28 May 2025 09:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1uKHBg-0001yt-S2
 for qemu-devel@nongnu.org; Wed, 28 May 2025 09:51:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1uKHBe-0002oa-LO
 for qemu-devel@nongnu.org; Wed, 28 May 2025 09:51:20 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S62Lql017452;
 Wed, 28 May 2025 13:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=cni9JkzC16V/IWleAx9RTfmkIVhK
 c7RDuEE+QsojQsg=; b=hQ2LnGPtwHPuRcOqT25U65NEXJ8oNxS5XcEhZmgiX29T
 lafXHEpX4s0CM3u98j8UsHWHSYoCbn4uur91nEC15vpPCJEcg54Mn4I6cRVXO+N4
 6wCDKZNBJPuLTlny5Eo/KkQOye1M2d8NmYYVIy0xuKEEGSckXKJm54Pn34eQNBic
 2YGEPtfaoyLO1W8T7MwscyOvVp0iM7eClb5Op7vTRwgGJUFIkh+6hmOFJlN9mxZC
 rt+Q3cnPXcMh4ogrmNYewZah/+kNtWRcemcCwEziRouHPY70J6ls9kluo6zBI4pY
 xSe6FNEJknvRVQR/O8bxn46h7Erj4eL4ff980YYCuw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wgsgn643-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 May 2025 13:51:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54SAQBtq016114;
 Wed, 28 May 2025 13:51:15 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46ureufxq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 May 2025 13:51:15 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54SDpEpU38077028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 13:51:14 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7CD65805B;
 Wed, 28 May 2025 13:51:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B251758058;
 Wed, 28 May 2025 13:51:13 +0000 (GMT)
Received: from [9.61.247.249] (unknown [9.61.247.249])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 28 May 2025 13:51:13 +0000 (GMT)
Message-ID: <31711771-7caa-4ea3-b763-45db6930e28e@linux.ibm.com>
Date: Wed, 28 May 2025 19:21:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
Subject: virsh migrate fails when --copy-storage-all option is given!
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ky9maYG_-AUabzHTwh5-gP4tSYzw2Jg0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDExOSBTYWx0ZWRfX3d/gcTSAo1Ag
 xagERNU9H4FMD4NaipmjNVRUsSuDwFljyx1lsrEXYN7QeEM0e+jprieaydZW7EHFL83A/pr3RoX
 VBT8nEGlaGWj+uhrgmIiJvpBkHpEsOqPc2Rv7iGTjo+34HOHE2JCHOAk+6eb4S9mza8mML+eP0R
 2B0gug1CtrpOy2Zx6zuSKCBGHRXdR5gzbt3jHTcxB3R+Ojpk3FSCwG1CUR1jazJ8c/BCyvS26a2
 iSWIruD0VkKpl5OfcyBjvxvYCSGFDPdYrEfy8e7MyY7TVa+NahiB5h8ACRk+jm7GtAqcqlsLTKA
 pSOgh/ETsuVQbj7A9mDSQUP3A7LJ89csSA8hWx1xKrZ1uc2r0bM4mvmOEluQ67Zv1caGzreHGuB
 coIXAyDsZNo2HOcgMG7/jg7KzCk5gPZhca3aXUQs7zBNLE4Vx6oelxqnGXYSriWzEct5xRS1
X-Authority-Analysis: v=2.4 cv=bZRrUPPB c=1 sm=1 tr=0 ts=683714d4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=B96gFoYMLmXjU1mJQAgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ky9maYG_-AUabzHTwh5-gP4tSYzw2Jg0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=991 malwarescore=0 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280119
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=anushree.mathur@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi all,


When I am trying to migrate the guest from host1 to host2 with the 
command line as follows:

date;virsh migrate --live --domain guest1 qemu+ssh://dest/system 
--verbose --undefinesource --persistent --auto-converge --postcopy 
--copy-storage-all;date

and it fails with the following error message-

error: internal error: unable to execute QEMU command 
'block-export-add': Block node is read-only

HOST ENV:

qemu : QEMU emulator version 9.2.2
libvirt : libvirtd (libvirt) 11.1.0
Seen with upstream qemu also

Steps to reproduce:
1) Start the guest1
2) Migrate it with the command as

date;virsh migrate --live --domain guest1 qemu+ssh://dest/system 
--verbose --undefinesource --persistent --auto-converge --postcopy 
--copy-storage-all;date

3) It fails as follows:
error: internal error: unable to execute QEMU command 
'block-export-add': Block node is read-only

Things I analyzed-
1) This issue is not happening if I give --unsafe option in the virsh 
migrate command

2) O/P of qemu-monitor command also shows ro as false

virsh qemu-monitor-command guest1 --pretty --cmd '{ "execute": 
"query-block" }'
{
   "return": [
     {
       "io-status": "ok",
       "device": "",
       "locked": false,
       "removable": false,
       "inserted": {
         "iops_rd": 0,
         "detect_zeroes": "off",
         "image": {
           "virtual-size": 21474836480,
           "filename": "/home/Anu/guest_anu.qcow2",
           "cluster-size": 65536,
           "format": "qcow2",
           "actual-size": 5226561536,
           "format-specific": {
             "type": "qcow2",
             "data": {
               "compat": "1.1",
               "compression-type": "zlib",
               "lazy-refcounts": false,
               "refcount-bits": 16,
               "corrupt": false,
               "extended-l2": false
             }
           },
           "dirty-flag": false
         },
         "iops_wr": 0,
         "ro": false,
         "node-name": "libvirt-1-format",
         "backing_file_depth": 0,
         "drv": "qcow2",
         "iops": 0,
         "bps_wr": 0,
         "write_threshold": 0,
         "encrypted": false,
         "bps": 0,
         "bps_rd": 0,
         "cache": {
           "no-flush": false,
           "direct": false,
           "writeback": true
         },
         "file": "/home/Anu/guest_anu.qcow2"
       },
       "qdev": "/machine/peripheral/virtio-disk0/virtio-backend",
       "type": "unknown"
     }
   ],
   "id": "libvirt-26"
}


3) Guest doesn't have any readonly

virsh dumpxml guest1 | grep readonly

4) Tried giving the proper permissions also

-rwxrwxrwx. 1 qemu qemu 4.9G Apr 28 15:06 guest_anu.qcow2

5) Checked for the permission of the pool also that is also proper!

6) Found 1 older bug similar to this, pasting the link for reference:


https://patchwork.kernel.org/project/qemu-devel/patch/20170811164854.GG4162@localhost.localdomain/



Thanks,
Anushree-Mathur




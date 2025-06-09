Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FF2C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 14:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOd3Y-0000xg-AB; Mon, 09 Jun 2025 10:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uOd3T-0000uG-6T; Mon, 09 Jun 2025 10:00:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uOd3H-0005Tc-MM; Mon, 09 Jun 2025 10:00:43 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559BFgwq017921;
 Mon, 9 Jun 2025 14:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=/dYtdl5CAJyiz3iBu+TGRrQj/C/HXi
 1GZdezvEFGSIk=; b=X+d4ja5lkE4K7KLiyAYN65Z2h7bg0SENVKolq6oSbQH1/Z
 LW8vEXbWYf6frTJOEy6jsw4n2aPxUve1eb27cpz9l5lNDol2zkiI3x/GEvVtAsOh
 IIk7hDGVBCNlBq3qZDJlNcvYXEV7bbwlZtq2eZcAq8i0bS0vg+afT1UYUQ4Zcsk5
 m2V944Yy544h8oFiI5Jlz9b4oorgF+Y75F5wRLsxKTE+9zoH9UHQyGEm7SKDSmqf
 g2OvdhZr7ySB15DKriscoITsw3WV/yB8KU78h6uQk8EUACjJzqad8L+a0Wr80Z0E
 P5lVbCyqa3xirRHJjEx86etGdIMeX6BUaEaiO6YA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hgu83b1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 14:00:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 559AEp7q014908;
 Mon, 9 Jun 2025 14:00:29 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rnwyrt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 14:00:29 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 559E0Sn821496404
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Jun 2025 14:00:28 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B8D15805B;
 Mon,  9 Jun 2025 14:00:28 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4BDA85804B;
 Mon,  9 Jun 2025 14:00:27 +0000 (GMT)
Received: from [9.61.253.10] (unknown [9.61.253.10])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Jun 2025 14:00:27 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------KH4AIrsVKO6SHSsIeHhTbSEq"
Message-ID: <8b806b24-62fe-4769-80fc-f6afe479e455@linux.ibm.com>
Date: Mon, 9 Jun 2025 10:00:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v12 2/4] hw/vfio/ap: store object indicating AP config
 changed in a queue
To: Anthony Krowiak <akrowiak@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com
References: <20250606183716.26152-1-rreyes@linux.ibm.com>
 <20250606183716.26152-3-rreyes@linux.ibm.com>
 <fb9f5bf3-68d4-4a2f-9f8a-e781e5059475@linux.ibm.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <fb9f5bf3-68d4-4a2f-9f8a-e781e5059475@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pfr/hjhd c=1 sm=1 tr=0 ts=6846e8fe cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6IFa9wvqVegA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=KeeneK6JeJdpitq1VIcA:9
 a=QEXdDO2ut3YA:10 a=VnNF1IyMAAAA:8
 a=JBATKl5ZXXqN6Tk8RncA:9 a=BLlm6C102OIL0WYt:21 a=_W_S_7VecoQA:10
 a=3ZKOabzyN94A:10
X-Proofpoint-GUID: 2a2d9cGVdsUN7zahbx9aCvlTv26RG26D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDEwMSBTYWx0ZWRfX6cFf6riBVtvG
 36EeyEj5RIEMlN7zl2D7FZpwSIP2nWDsotnqUICn+jcSSJzVkXJ1JvCXrweU0BzfahS3mXgILn2
 aIo1PQOXJNSHDN8mfHQ6tMs2QGruvMc4b9UErIndNvX3SgbEGXI4tNq5pgeI/MYLgXDdDhkew2C
 LQdF0tJXE4woU7IEPAuZt6buMN0PIaddUJ/vp6av3ZTlQqQ4yPVCXyAWkDofqapLBuznIQjotOj
 4QhZIzKe6bSLHez4YDWygDDwH89QEKMq5vu/+uGTT86NEa7LpEStq7EOsFO8BqxlAnR9H5X+lIo
 5KVasMlMQ0MX9+l5b9RUkH6D2abtEWNiVFSnsKCuLDJzkC0KDsog2AW/AvmXywEyzdESk7M3P2M
 rVMS6pXojJl815AxTQxTTzTDMBzjlosgz5febSvY8wjxQOaxz5VfXnpujdlKF+8bVB73DDOs
X-Proofpoint-ORIG-GUID: 2a2d9cGVdsUN7zahbx9aCvlTv26RG26D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_05,2025-06-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=865
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506090101
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is a multi-part message in MIME format.
--------------KH4AIrsVKO6SHSsIeHhTbSEq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/9/25 6:19 AM, Anthony Krowiak wrote:
>> + QTAILQ_INSERT_TAIL(&cfg_chg_events, cfg_chg_event, next);
>
> Need locking here:
>
> WITH_QEMU_LOCK_GUARD(&cfg_chg_events_lock) {
>
> QTAILQ_INSERT_TAIL(&cfg_chg_events, cfg_chg_event, next);
>
> }
Wouldn't QEMU_LOCK_GUARD(&cfg_chg_events_lock) be better since it's a 
one line? Or the fact there's no return here makes it insufficient?
--------------KH4AIrsVKO6SHSsIeHhTbSEq
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 6/9/25 6:19 AM, Anthony Krowiak
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:fb9f5bf3-68d4-4a2f-9f8a-e781e5059475@linux.ibm.com">
      <blockquote type="cite" style="color: #007cff;">+   
        QTAILQ_INSERT_TAIL(&amp;cfg_chg_events, cfg_chg_event, next);
        <br>
      </blockquote>
      <br>
      Need locking here:
      <br>
      <br>
      WITH_QEMU_LOCK_GUARD(&amp;cfg_chg_events_lock) {
      <br>
      <br>
      QTAILQ_INSERT_TAIL(&amp;cfg_chg_events, cfg_chg_event, next);
      <br>
      <br>
      }</blockquote>
    Wouldn't QEMU_LOCK_GUARD(&amp;cfg_chg_events_lock) be better since
    it's a one line? Or the fact there's no return here makes it
    insufficient?<br>
  </body>
</html>

--------------KH4AIrsVKO6SHSsIeHhTbSEq--



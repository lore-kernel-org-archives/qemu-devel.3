Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9E9FD8770
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2V3v-0005as-1i; Tue, 17 Mar 2026 10:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1w2V3l-0005Zc-Hz; Tue, 17 Mar 2026 10:06:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1w2V3h-0003uE-MR; Tue, 17 Mar 2026 10:06:11 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62H8CiEI801573; Tue, 17 Mar 2026 14:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wapRq7
 aHsw0R5YtTLW8posa/QB43yLBU5c+ZLi0zRwE=; b=e4gb8zMqPwvMvdlrCAzlco
 8WYRGI29m/PKiO15yvKnGxVVvUh+4A4yoXeo/R2I3Y0PALoBlSrSFgSHBGEItZFs
 +qgJQo7jQIDZMlXTqSJKE9LVyFiELSs8hi31zpf8s44aHAM3mhMaaIwHoRNICf6z
 zZkG6whRTSl6kqKF0hNOX+hwbrwGuRYNHVsyxMMOq9uI/S+WcA2p54XaZPyJqfR8
 NyaLUWM96WBrnNfIa3COzoCIJgg8OBWUne9JWCJMtd8Q9dXx5apX4Q8U/KnsgqHZ
 a79f4wjlqD88omxEc0pbCKNwy5zAqensJozXU/AJMB2ctFS/3uTLjVOk0VjAH6mw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cvks0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 14:06:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HCN7d5028510;
 Tue, 17 Mar 2026 14:06:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq197uf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 14:06:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62HE616X27984502
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 14:06:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35E6A20043;
 Tue, 17 Mar 2026 14:06:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04EAA20040;
 Tue, 17 Mar 2026 14:06:01 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Mar 2026 14:06:00 +0000 (GMT)
Message-ID: <3b0440b6-45c2-4351-b6fb-990edeecf05a@linux.ibm.com>
Date: Tue, 17 Mar 2026 15:06:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x/kvm: Simplify the async pfault handling code
To: Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
References: <20260317134531.460141-1-thuth@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260317134531.460141-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b95fce cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=1PiBuSbX7Db_E7daJGwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEyMSBTYWx0ZWRfXxMjk91+ozVz7
 fYkOLICriTcVYCjeWaFjWUEjl+Cph1m6gwtpRmfvxyNCt1/EyzGbx/mxrvEXd9Oex+EK6nMnprg
 AzwsOl2WU6tllIEdZg2nhiDksPqEdpXZY9ngux+Jovf3pR5tQ6PHpfdXzloVuqZOxU5XwIVAXkN
 lqWybrer9eEca8OiN8p70hdqxdBFmYjB4SdcHZD8I6WY3cgLEJw+5aaFWlaxiBIwxDCsdWxsFBW
 oTSA7RXcFJxgHCSKmDlVvDXmfrOwTFBOqX9WzS+fnP5JlDc4Q8zx4GKV0lwM5H39heu+SWttqYW
 OxYvcoyqa96LAiZscPx6SrIcFv1nXD1bwLjqTnb8kAGvmVSsZTKok5Y9UH8dGyUYuHNfzAer5zs
 qpfR+NW4cVih2ZoNFwQj/uOf07ssFTWWRZfXqreEbH8bzFb2C+9LiWUwnVKTm2a8Oj/lIOOqb0f
 3JCdFE4bz3i2vft8gIg==
X-Proofpoint-GUID: Wng5aeFiUx86OhOkuKk7Me-Pxk0MMfcA
X-Proofpoint-ORIG-GUID: Wng5aeFiUx86OhOkuKk7Me-Pxk0MMfcA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170121
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 17.03.26 um 14:45 schrieb Thomas Huth:
> From: Thomas Huth <thuth@redhat.com>
> 
> Since commit 126e7f78036 ("kvm: require KVM_CAP_IOEVENTFD and
> KVM_CAP_IOEVENTFD_ANY_LENGTH") we require at least kernel v4.4 to
> be able to use KVM. KVM_CAP_ASYNC_PF is available in the kernel
> since v3.15 and KVM_SYNC_PFAULT is available since kernel v3.18,
> so we can assume now that they are available in all supported
> kernels. Thus simplify the code a little bit by removing the
> checks for these features.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>



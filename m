Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE7CC54E55
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 02:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhguu-0008UV-8V; Tue, 05 Mar 2024 21:22:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_tsoni@quicinc.com>)
 id 1rhgus-0008UN-Dy
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 21:21:58 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_tsoni@quicinc.com>)
 id 1rhguk-0002qu-GL
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 21:21:52 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4260WX7c025613
 for <qemu-devel@nongnu.org>; Wed, 6 Mar 2024 02:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 message-id:date:mime-version:subject:to:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=PwvW4kuLwBTXMlYVqwsuJGjd/tzgqFuQFrFsa4V+lsc=; b=LW
 C17zE+Hr1Qu+B5XZuIZtQ9vHhUDJ0gh9C3sQo80iQbMxJxRs6cYgEkdzl3ZkF8ee
 Nx8RUyWMqF1QupaXG0w43IYIBqQKlmu6C+PpKfE9JPF7Q4AVon8+Ek+USr3oZa27
 mUEOVsfe1HwwniJXddTXP15XdbeY9zisTQiD1YOqxeQ76A6fLQhrVsbmg3bowRD2
 dO0goMqz+b4AhEeb5A5mCWGv6sS+lG5VFVTukO3OqSRZohGCFVeCvXELJxpLzRb7
 yTXjqqiqSy8dg/v70k5oK48eX8mgZ/ofz4y6lVQru0tqf63f4O2EtJdgGvcFSgDo
 +VFHZnI99CdFGrAGwtfQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wp028a5p3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 02:21:47 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com
 [10.52.223.231])
 by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4262LkQh027409
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 6 Mar 2024 02:21:46 GMT
Received: from [10.110.10.37] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 18:21:46 -0800
Message-ID: <e2d24e7b-7272-5dff-eea4-3e0a9e66dd7c@quicinc.com>
Date: Tue, 5 Mar 2024 18:21:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: ARM hypervisors
Content-Language: en-US
To: <qemu-devel@nongnu.org>
References: <CAK4oD7BPCf5o-OR8WThb3QGJbrJnYpHipjKv-hY9rkWNOSAHjA@mail.gmail.com>
 <CAFEAcA8wQK_jfj+q-70TJ9Mnu+JHan_oNPYTDMMUmsBm7kMcOw@mail.gmail.com>
From: Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <CAFEAcA8wQK_jfj+q-70TJ9Mnu+JHan_oNPYTDMMUmsBm7kMcOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: h6fL7_mBWGxLEwvzo-DdefbsAMWOvIbe
X-Proofpoint-ORIG-GUID: h6fL7_mBWGxLEwvzo-DdefbsAMWOvIbe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_20,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=644 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060018
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_tsoni@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.98,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/5/2024 5:59 AM, Peter Maydell wrote:
> On Tue, 5 Mar 2024 at 13:40, RR NN <rnn59437@gmail.com> wrote:
>>
>> Hello
>> ARM hypervisors (pKVM, Gunyah) can run x86 OSs?
> 
> No. A hypervisor uses the host CPU's virtualization extensions
> to allow the guest code to run directly on the host CPU. This
> is why they're fast. This also means that they only work when
> the guest CPU is the same architecture as the host CPU.
> So you can run an x86 OS on an x86 host CPU, or an Arm
> OS on an Arm host CPU using a hypervisor, but you can't run
> a guest of the "wrong" architecture.

As explained above you can't run x86 Guest OS w/ above Hypervisors.

You can use the qemu/crosvm w/ above Hypervisors to do the ARM64
guest OS. You may be able to use Pixel device as well w/ the pKVM. 

I also suggest that you don't do the "reactions" with gmail. It 
doesn't help this conversation. 

Let us know what exactly you would like to experiment with above
Hypervisors. 

-- 
---Trilok Soni



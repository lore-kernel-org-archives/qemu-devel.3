Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89595C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 06:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd28s-0006Td-J7; Thu, 22 Feb 2024 01:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_tsoni@quicinc.com>)
 id 1rd28q-0006TQ-BP
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 01:01:08 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_tsoni@quicinc.com>)
 id 1rd28m-0008DY-EE
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 01:01:06 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41M5UGNW004932
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 06:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 message-id:date:mime-version:subject:to:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=dmJhoCAhkgfwrO/jnzX0XGpLOD1V9DByG6XAosiivzg=; b=ix
 A7iOACLTEob1BRCwzQWM/4aF311qdDXOBdF8xhS5vBweA3e05CkV4Vn4DPusSIY2
 1Ij9Fl2W+VrIZNhy379YVJv6UdcfnXWrgaNYN2iQfByUGE5zrzhclQ6K/zhXGZs2
 x7T/VNnYzZEi1Up8mDFo4CBJCTGFuYE9rdzM6tO2hXIQS0WdnBdIVV7IGrXbKWoS
 mS6AaODcQUIj5BOVrkHtJ3VUtM23EJ629ebZ+eG72SvD/B8sVauQFBlVvmjIJgD7
 WZciUb4QFG5Li1clJ8MJroj+GEJX/2pytgPLs2zn+xt/h6Gv2Q9vDC35KB0/FZ5N
 pz8vw+mj5twfNCTxqt/g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdgge28de-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 06:00:59 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com
 [10.52.223.231])
 by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41M60wg2001659
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 06:00:58 GMT
Received: from [10.110.27.83] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 22:00:58 -0800
Message-ID: <f89cd017-5d8c-f2fa-1702-1705bad1ba10@quicinc.com>
Date: Wed, 21 Feb 2024 22:00:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Support Android hypervisors
Content-Language: en-US
To: <qemu-devel@nongnu.org>
References: <CAK4oD7DS0WiZcze37b8ERh50_ht=HNS3Bk8aeRmCjx_ndMG1gw@mail.gmail.com>
From: Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <CAK4oD7DS0WiZcze37b8ERh50_ht=HNS3Bk8aeRmCjx_ndMG1gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: pThnioIewtGNjzP5yK1tBtEQLlNcglBF
X-Proofpoint-ORIG-GUID: pThnioIewtGNjzP5yK1tBtEQLlNcglBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_03,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxlogscore=661
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220045
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_tsoni@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.297,
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

On 2/21/2024 9:37 PM, RR NN wrote:
> Android Virtualization Framework (AVF) supports "KVM(pKVM)" also Qualcomm's
> "Gunyah" and MediaTek's "GenieZone" as the hypervisor. Please Add these
> hypervisors to QEMU.

I don't understand this comment. Do you want QEMU to work as VMM as well
for these Hypervisors? AVF works w/ CrosVM as VMM. 

Recently Vatsa had submitted RFC for supporting QEMU w/ Gunyah. You can check
that as an example. 

-- 
---Trilok Soni



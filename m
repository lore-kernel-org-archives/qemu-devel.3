Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581E1C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 11:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tus18-00028T-Jf; Wed, 19 Mar 2025 07:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1tus15-00027w-Ii
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:55:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1tus13-0006v6-Lw
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:55:23 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4lktZ026897;
 Wed, 19 Mar 2025 11:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zOXzcStF85Pgzc6hVA6yQWt41wqToZwhIlNOGOH1hak=; b=RrAYN+/Ft7I/tDGI
 z+PGlICrL1841XXyIQ99EcQ7Yso2aB4uZqP/ed/f4T8VFFhvtcGC1KZ7mYrincrg
 KChbigEfMLT5I26FIGuD7h9lmNFVCMnNDFUzA+bmG+bX5+Hi0fohB4ZIc1O8TNkv
 z0y98UwzvNSXEcaND3h2Rz+BMgYrfjg5UIm9/MV2pgXZyv8Y/+f1tuKeldy3v8vY
 oS0EEat28xT51GM9b5Len2XvJo44SZ49LRyjgZhwv5yACjadnTb4jjDRkfWw9P/F
 dTnRP9ZGmxl16SZik+51coH08E/FhTlgfknMfjzcvqn5vSXZc0KL4o1P9MP3Yy/V
 NzYaYA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45f91t3axu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Mar 2025 11:55:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52JBtHjO003290
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Mar 2025 11:55:17 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Mar 2025 04:55:17 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <thuth@redhat.com>
CC: <qemu-devel@nongnu.org>, <quic_mathbern@quicinc.com>, <peterx@redhat.com>, 
 <farosas@suse.de>, <berrange@redhat.com>
Subject: Re: [PATCH] tests/functional/test_migration: Use "ncat" instead of
 "nc" in the exec test
Date: Wed, 19 Mar 2025 04:55:07 -0700
Message-ID: <20250319115507.1245655-1-quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20250319105617.133191-1-thuth@redhat.com>
References: <20250319105617.133191-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 507jzZ7RlsvuFForcD6BxGjXOA3lzEJG
X-Authority-Analysis: v=2.4 cv=Xrz6OUF9 c=1 sm=1 tr=0 ts=67dab0a6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=3H110R4YSZwA:10 a=Vs1iUdzkB0EA:10 a=FP58Ms26AAAA:8 a=20KFwNOVAAAA:8
 a=COk6AnOGAAAA:8 a=DMV-XOtozuPzXTjrwUIA:9
 a=zZCYzV9kfG8A:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 507jzZ7RlsvuFForcD6BxGjXOA3lzEJG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_04,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=415 clxscore=1011 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 19 Mar 2025 11:56:17 +0100 Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
> 
> "nc" can either bei GNU netcat, OpenBSD netcat or NMap ncat. At

Small typo s/bei/be/

> least GNU netcat currently does not work with this test anymore,
> though the comment in the test says otherwise. GNU netcat seems
> to be quite unmaintained nowadays, according to its website
> (https://netcat.sourceforge.net/), the last public release is from
> 2004, so we should rather avoid that binary.
> In our CI, we are only using "ncat" in the containers (it's the only
> flavor that lcitool supports), thus to avoid silent regressions with
> the other netcats, let's limit this test to "ncat" only now.
> 
> Reported-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks for the quick patch :)

Reviewed-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>


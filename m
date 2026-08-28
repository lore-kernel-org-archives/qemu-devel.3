Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE20BC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wztZF-0008C2-1S; Fri, 28 Aug 2026 06:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wztZD-0008Bk-Rt
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 06:12:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wztZC-0000mI-9u
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 06:12:11 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SA88pj2596142
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 10:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KFHEpAzofODBCAtYpK8flaMKjwewVs/ExDx8uNaQKig=; b=BCPLUGMFy+1YUcQJ
 iaRg/P4pvI9qXDGpMnZgy8qGqQK/d8nxRbvnstJOJVWVsp2l+XUAONKBz4gL8Oxx
 FNagIFtefUHsrLjcWpvi+RwKsPGhEZ7S9hQnXr/HQ1tzuJHzyS/1O33gEhLYlpPt
 /vZn/3QS5h9EpK0xISdplbNcWpfmEZKDueuxhGpzdQpESPcYAAslCJmwW1HfY/AK
 RPBCWPKHyscT2GIPswleok5HkHlhVXRvtlYmU99Je+xMnqOuFWi9LANhUH6Xmy34
 HccR0j2YHjVv51S+yNYm0SWkkWDFKGwoCUir+EHrmkonSbXGTRU+xNNakQ8AsybE
 AfCDwg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb1v39npu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 10:12:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52d33c89a29so17745191cf.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 03:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787911928; x=1788516728; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KFHEpAzofODBCAtYpK8flaMKjwewVs/ExDx8uNaQKig=;
 b=kr0Ei1n16jEhUe2d3aAM3ELjeqqgawZkV4yjozC6y3ku5RE+rhu5hZ41iwmcXjlig1
 mwD6VfRrypc+J2x+joJwNNMLPANfGdNvGiQlCrlTu/iixDoEBlX4C5Qw2eDZAC0NuwV6
 zLl+pC0FuU8s0xpd/3lBWkehTw9Tca6gsMVuhR8e2Lg3DPNwxxRDtD6dXQX6udfDGD+j
 6H82fs/GWJHaZhXRQ2y4o7YDsGU25nxbnuYc22aLL7UBUTIfSYAjWP5Im4C1qflgZM6x
 QEnFXzJ4zTamsySAnIYj2dtosdEczWqlWLkkhawZP32mjHGF5bZqKqnpAVfb9cDrVCfa
 poRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787911928; x=1788516728;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KFHEpAzofODBCAtYpK8flaMKjwewVs/ExDx8uNaQKig=;
 b=AisVTcliKBf9QV9kQO/8kKr1onzDcJjbGRGGo5hmGN2zUAx30RoV2Yxsbl5NRvOy+R
 nJez5qRpHwbmPc3EhhYzFFEinUTySshE3MZfFGQNONWbQhOZJIwMkGfbG29F0XLs7Swz
 EFPq7Am1m3rPMUfrNpIGKqsiFe/g6KtGH/SkO41Ipuyc7oRyyAUPNKxWadm7zRC2086H
 /M4wpZh4P9ig1sDyw5mGcnN70w4ck+CLBXzB+A0fR8uhPY+iTsj+yaWNDZPUZg1zoQyx
 ArBIGNcm3kyT74ZEdKiy94IgOciWCTd8PlEANhujzzbOQVL6lbBoqo0OUKLNyqZFJ5BI
 y2lg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rox9ylECHTYW9wekLDDB5rvAt0klFA5s0XzMdM1iPk1yctKkKg5QGDbK926XjX1pTleL/dzSdn368vR@nongnu.org
X-Gm-Message-State: AFuF++mLDOfCVKkJQBwEqMy4N3mJ12sw/NGxpHhD/nBKoSbjRBeQu+UW
 pBSC3haZFzqPNnmGQsENV2cnOjPSmNbQ9OAwwph64BM3Qj5YnzmcKpHbmIDmi+qvMCNtArY2K7s
 BUcMEZfdwOkIdwAYYKOWYG4uGLWeJxTO2oHtFKTM/L4hQnXd7RF6y/oWgMg==
X-Gm-Gg: AR+sD1271eyRKn2Y7vqUy3oIlPT5H/eJdwWc5iJVn82ex8vK15S7GRUtm85UOEAm7FU
 fIfE8nB4Rpkp+rDhgOgCjWC9e+aPqkBO7TUZUza/jdtlNHiMTsNPy2uC8TI0qSeTDz220dhTAOg
 rhYmnA6SGvbypFQPOXTzR6q/bh2bYYaapSF1UBipWdYc1nUfLeukNDc2yqwxw5qcrY0JtTPliHa
 tuasQlI9EbJHMFmii9T8cKxf/WW8hbmslme6Xq3PltD7oLT9jMqk4t7y0OkPjI0nDaVzhOr7RWJ
 ZjzeMfKITt+gxbhgfI/RIIt0R83xk12GE5qZwf0JvC43c9glRM6GHJEKX0NUBfzeSMwgxk2aKTk
 s219IhpqG2Lb6Y76Wpn/8+9Vy/fPU+DSTeg==
X-Received: by 2002:a05:622a:15d3:b0:516:d699:a99b with SMTP id
 d75a77b69052e-52fb9675b7emr51125921cf.40.1787911923270; 
 Fri, 28 Aug 2026 03:12:03 -0700 (PDT)
X-Received: by 2002:a05:622a:15d3:b0:516:d699:a99b with SMTP id
 d75a77b69052e-52fb9675b7emr51125501cf.40.1787911922732; 
 Fri, 28 Aug 2026 03:12:02 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3fcesm2855350f8f.5.2026.08.28.03.12.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 03:12:01 -0700 (PDT)
Message-ID: <d3648fd5-78b3-4206-9777-4a98d7e522dd@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 12:12:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/49] net: add x-query-network QMP command
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: dave@treblig.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-18-af60857c2fbe@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-18-af60857c2fbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA4NiBTYWx0ZWRfX1YNyz1u09w/C
 xc/NBUHlTFxYAmGNV/6ghSe8B4CkKwCxcLCm8n9BDE86/e1X2lpFiA+bdjd+/saUWP18xoEu7u4
 SsvrCSWOylxVUkTrtXZ55EzEIe61KV0mRIjeeuoocb0R5A2bbcGyeg40BCbAEIQkYYkiVbfzy6b
 evLTvdvaTLBjDGzOZfwgZvdDv+VpfYN2H7cgrES7QcbmECFVvTDBDKcX+Ec8uclySXygWSkD34t
 LfILCRky9IOEF4kbncd7bxOD0Ii1v5ciNeXODsZbR6cF8KNFoEkEUSEMZUkqAjjq0b7frkk90bl
 Ct/b4btBSX+lpvoqGmU2Au7B05tnwKU7hP0LYTJKHGWcCPbUzyDlAXqrXmtFHBr8vxG5occUz5d
 ioCvPccwYcoaaQXqn7sRL46hJf9K18aKeHvjhZx9ERvb3vqz/HbRhssazwwEupZuuG2hg3MOqTO
 HXcK2F/ha98AMQ0W0Vw==
X-Proofpoint-ORIG-GUID: tzElZYlipBaN2-_ivC8H9_4npVBg1_kW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA4NiBTYWx0ZWRfX6F1s3Gp5Bj6U
 zccs3FtOZWwfAAFqj3y+1tU5e+f7qOG/xVAP0wL+YTRLMR46y3S37O6i4jR1iJsU30GO1q9ubvc
 MwajghHCulHoDnjAu4RJ++qL6TuP5XA=
X-Authority-Analysis: v=2.4 cv=faedDUQF c=1 sm=1 tr=0 ts=6a915ef8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: tzElZYlipBaN2-_ivC8H9_4npVBg1_kW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280086
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25/8/26 21:09, Marc-AndrÃ© Lureau wrote:
> Add a structured x-query-network QMP command that returns network
> configuration as a NetworkInfo struct with pre-grouped hub information
> and a flat list of non-hub clients. Each hub includes its ports with
> inlined peer client info, and each client includes attached netfilter
> details.
> 
> Refactor hmp_info_network() to consume only the QMP result instead of
> directly accessing internal net_clients state. This decouples HMP from
> internal data structures, making it possible to remove HMP support
> without losing programmatic network introspection.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/net/net.h  |   3 +-
>   net/hub.c          |  29 +++++++------
>   net/hub.h          |   4 +-
>   net/net-hmp-cmds.c |  57 +++++++++++++++++++------
>   net/net.c          |  70 +++++++++++++++++++++++-------
>   qapi/net.json      | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   6 files changed, 242 insertions(+), 43 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


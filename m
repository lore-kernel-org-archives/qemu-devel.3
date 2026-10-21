Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C6606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 01:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aTQL8lxx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XMZGZWe+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJLEd-0004A8-51; Tue, 20 Oct 2026 21:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJLEW-0003ya-Ad
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 21:35:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJLET-00036y-Jy
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 21:35:12 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KKti8A2222666
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7z5JROiQGsVEXRc2q/QK6CixwI4jlJn7rzyaTlAN8vc=; b=aTQL8lxxf6YlTP3a
 RRGM1BIGBazfW9+P0jU5slhbpGpJXi4sSo1aHwwJw998um8gic3tcXID1EqCohGV
 sUkn18W49+ip8w9IjrPeokfa98t9pdDcHCqOiGdr19AMCNrSojFNXLisSDZBnM++
 1h1wLjV03izN68ws+WvCc/cgFsYbkv1sfhV9qm+VWorygNEJB/3nQ5FwAfSQRzSg
 Y4qFkyK9OaNXj7nrWp2ZlIhOprXDFMiHMnyslpScHVvLqQOsZznLYGYrwHeYZ++M
 wXsmQAMbwzkY0ccI1R7cdmWfWg8XIA59I47uIrZUJj9dTTHiartmNBhFlZLqXVbl
 8RBlrw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda0hbr6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:35:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f37c94ceeso245417385a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 18:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792546504; x=1793151304; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7z5JROiQGsVEXRc2q/QK6CixwI4jlJn7rzyaTlAN8vc=;
 b=XMZGZWe+60hqoeSI4eWT4OZRsLBrbSzwyzFgYmaHYQmp9Cmb/7jStZwyeYgDFrKU4Z
 A3MrxdJsaZWAUJecLt/yXtQ2IPdh4XgGMgTZrPpVqFX5J6TIQqIJhSjocsyGmFT7cikZ
 3JwVRKpo9Egai8OXelyS+92vcohR4YUHupmOI36Oj+vvvJqwWo3nEg5RHI1Nqf9SiKBs
 69DUbZqwzmc1rDLrsSlvaGtsRrXtYL5SIZCnvkap/rHeIxcdoiuBNsQWDX8B+tiyib2u
 r0ppx1aQerYuBpSRfCcPGmkoo4xZ+sucC/jDE0V/irfz+zisZSX05Cy7su1UO1OgkWtk
 nYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792546504; x=1793151304;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7z5JROiQGsVEXRc2q/QK6CixwI4jlJn7rzyaTlAN8vc=;
 b=hgonTNIvkwwxNopmWyRM0GPNFkUiYYpGEZvN2eoTnVB90GAA+rfSZlVfv0uohOSAfP
 +s9rX2R9NdUHmFQ4AKWPuPc0SAY7netPcIPqAbjvxxZKKk3V1wY/T+NDBmwICdlPHB1r
 +OC6r010PkmaILB1/FJgeZjLiLHSAieHWeYCIBdDpBB0cR/lpCmywUoBSW63okeuPBR4
 yp5Ly3kUPvBoViJMa8oICi861fSQbXge8EC+MSro2YqGFc6haM1nivLLueeYKX2Aq5li
 NeH9ruieaY7+C1utgPi9Fq3LuTyoiLt8Q5zuLUd+K3oXVeFi+uUn0lSy11Z8hxmuIaxn
 nJ9A==
X-Forwarded-Encrypted: i=1;
 AKwUvBydLWJHCOl6sSq4krsrYMVfzsrOOZsqQr+VIdxcb7/kIe+cL3YR7v+dgX8yF4oVaheYuyO1UEd/uWxm@nongnu.org
X-Gm-Message-State: AFq9FYJQZGfxplJggR4Tn9W0CkvsItBH2ALKppW209qd38EZNnDh0hYh
 ovyfvWNCC8svdGNk6bFfTqPmfGEP2geyRjRpX8BwOhrIm3lquzpEu+QtuaUnvXLMHIMG/Z6ANQ7
 QwrdN8mmpeWKieWL0MEYtL/W1eNnmQlZfALYB/88PZfkhNKr7w3RspLBMjA==
X-Gm-Gg: AYBFou3Vo9jYyQGsKWYUhXHXJi0wLIZ2nAZxXDc6ea3eiIen6ffM8moWR39TPRmwl84
 /bB/NXJWkpr2RFsOvR8wt4UcKup73WDbUGHauNm7TUXDOgbOFEk0vPuv6w0vnX9tcpLondCKQSf
 uMcS+yl6JzstqXp2ruXu/1b1qJ6Pa7zul2uPVE1lamHcp/2ejVpC/ipdqQQOoRtmHh5LIZ7COBT
 yX2tzJiNrRzVVe9lC/gTblxD6TNK22JxpFykOK67Ml8YJirS7U4QFvp2OtIkLJZ96GpbbTKBv4Z
 stug4zqKokwQhmZkwSLvI90AmZ/WVsvAkdBQ+v0r7DVr08H4nD7tMIASeUGuVqiMedd5un5zUqC
 0tgYlZgheF5lcybuG/G9QieW1Tbbh1iVOew==
X-Received: by 2002:a05:620a:298c:b0:93c:7861:675 with SMTP id
 af79cd13be357-93f4c195b61mr653288585a.1.1792546504438; 
 Tue, 20 Oct 2026 18:35:04 -0700 (PDT)
X-Received: by 2002:a05:620a:298c:b0:93c:7861:675 with SMTP id
 af79cd13be357-93f4c195b61mr653286185a.1.1792546504017; 
 Tue, 20 Oct 2026 18:35:04 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fb859326sm39065445e9.10.2026.10.20.18.35.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 18:35:02 -0700 (PDT)
Message-ID: <b32b766d-4b93-4aae-b5dc-b060dd52df2b@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 03:35:01 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/21] target-info: add target_heterogeneous
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
 <20261019212648.154493-2-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261019212648.154493-2-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNiBTYWx0ZWRfX/1qHgLBSx8Pa
 Pt8BHQMDWBIi/quRw2/ytq2L2UIoCnVPqLq7lyGiN4j6oBYV5vu2BXSt7HRlX7+1+rnfshgvWJI
 nrFlKiSHGgi1yX9JWbr8y1Tjd4U7BLl9LqfseOiLqoSqCDiSbcg//aRSZZ6+a6aMg/ycZeJHN8X
 CMAt2uiP44engTXqcxEAPWlk6idXSb3sZk9RuZ/B2NkxHTNlv0HbATpO5+jnAW7Z5yuILggC+qn
 9+4pXJQ5AIZ4dj9Ey3M92QDWK1R8CsXecBJmgvr425LWdRKO42Ktr2w/rGgSN8wB0XaG5TAvzaZ
 OXcLJJeZApV5Hf18pwD/E8niPpLOJQken+XT1n04AW6RiXD1SL5b26eSyjXcVx5r2u3yzPkYCX3
 8qJDoAGNfgeIzofY6WbfpVVyR3B/mK6nzpop0WPjd0+MaOSoUvYhCjWbz4miztVNgbR3Y5Ubv4q
 uzIKfti3sH26T7/gGJg==
X-Proofpoint-ORIG-GUID: V4RRnYTZxZZ0v3xjOU1G3RhIf0oSMAK8
X-Proofpoint-GUID: V4RRnYTZxZZ0v3xjOU1G3RhIf0oSMAK8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNiBTYWx0ZWRfX4zNS+v+u7BOI
 v6pBfbWSfdQGUaqT42IhhK4CmTNpQpTXk18Pk5KDdTlQSTlnTU27/8crl8OmaeMNzc5S1arIOnv
 CwzVAAjrOkDIDpDxalFT+t2YerlffVQ=
X-Authority-Analysis: v=2.4 cv=HL5WhYtv c=1 sm=1 tr=0 ts=6ad816c9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=nEA20XZNpb331UcwqYkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210006
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19/10/26 23:26, Pierrick Bouvier wrote:
> For now, this function strictly returns false. We'll turn it to true
> once heterogeneous emulation in supported. Meanwhile, we can use this to
> add various checks and asserts over the codebase as reminders about what
> we'll need to modify.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Anton Johansson <anjo@rev.ng>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/qemu/target-info.h | 8 ++++++++
>   target-info.c              | 6 ++++++
>   2 files changed, 14 insertions(+)

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


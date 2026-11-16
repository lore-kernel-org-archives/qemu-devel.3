Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FBF606A330
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oRnTOYlq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EdO/dsxS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT44H-0000PF-Nu; Mon, 16 Nov 2026 16:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT44F-0000P1-ES
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:16:47 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT44D-0001GK-Ua
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:16:47 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfQ0O2729093
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aiUO6gt6pKaW92aX6yG4t2AZQ190h3FUIV7r6NxCSso=; b=oRnTOYlqNA6xIYpV
 FhtxRnpRby/dzwSRixeUojo6SVwCvx1NddrK09tjI+muYNLQT5wUoCtOjcrkq9xf
 ojoCGV7Iz0c5V8kLMArYFTpIt4JamHfnBraUuAYjMsNe4efX8mwq9O3mdPjBDUl5
 BzdODr5sctwwTRHS4S7tNFfKVZ22FJXBCv32GA0auUbr6dC2KoA/fCzNDphSTnns
 cLQ1pB/JopbNHiK5lZX5vu+33fw8aG/sU9GXaYbRiztNIfp2Inx3G30EM72EX8Mi
 p4uSK1jr3SDQ5T2CqTGRyDuTRmf8fEIibEkTX9AGPSEoyh+QJd0FCebt48jr/UjZ
 HnzMsA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j07regfgc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:16:44 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-37549877380so5247496eec.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794863804; x=1795468604; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aiUO6gt6pKaW92aX6yG4t2AZQ190h3FUIV7r6NxCSso=;
 b=EdO/dsxSDipES/hy+MYvVktuDkptqkKlUUgzbFBt0wIbf2zJEKdMOjgobCvQg9sTmM
 YJM0xIM0iasgiupGPZQZAudRNZNLinMn9Y4NfFau/bjWrdtLZYpfBezbXlxMixVP+SoX
 iv8ZvqcI9M1s8qTKisj2eC+9lnNjyCCUEXGl9Mnpp8kUzYQFCz5FxUqzc2CgJ9r9K8T9
 O5Ruby8FsZGp3dL5FgelGAmjNZBzvaPt7tk63csy0An7dTmWd+47VHE0M/y2x3/n2yDI
 WNV871CKa5DK3bx3jDVmzrI/ySQRROq6ivQ8reP6tBFLvsNfKRy7cmJD3VNvXnwh+foK
 IrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794863804; x=1795468604;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aiUO6gt6pKaW92aX6yG4t2AZQ190h3FUIV7r6NxCSso=;
 b=KSvhqzAKo9Tp71GgzXkhhBCZ5wRmoCK0uGH155aHDgtLyu29vQRgecp/vwfE6ywSf5
 bMu5faCe5CEpcbXRmj77inFhKnAmAh3tZgj+TawKDzCwhEyJrnJSF3VN+z63QZd3HLft
 YMnutJkOXM/H5e4AV6vBVDJsgnEaoIcocCWHsKedsW6rAxT8vG2POVkt6GSWSGDoGxgT
 ryk+n1M01W+EDhoSaUR7UQMka8sAkF6vlsizJuVvE3dthk97vh2Tn0soUkPIMPzeqmbz
 xinyxMwaZJwf4gy+Ql3TAoABWrwbIgU+aSU64kHahyHx5Am3Kso028VNjuWSB5pOiohr
 E+Sw==
X-Forwarded-Encrypted: i=1;
 AL+hErGuZyuVU8iGx4vwCxGN4iDoWBManAnCUViKv/XAhSivyQK3Vh76SdIibC7oHILDva8Lu/wijUOQQNQj@nongnu.org
X-Gm-Message-State: APuU4Z+Uof8K712lDYfuZ4l1Qp5O0SHCaUDiUgimllndMT0c+skNC8i6
 +QWyw6kRNhDRq4tUZU8Ki5zTstBJ4gOYpaJU0qrAWv8fMnh2OGNtxhpJsHdKlkqvCZRDv0oq3Xk
 wqZi6fOib3gz8qphPXQARbtk+Bi0u55pqqVVJKzVVsKESUZOwMWkw0Bzeug==
X-Gm-Gg: AZFdTZfIcuYIbv4HXxmb8RlFK+mlFbNu3tiKaF81axBGkocAr4T8dZhKpEz8qlpgOgx
 n5aCEvXXRNf1kHnI4uqL2cp6TcJvkvOGsm0vd528euz/EAyb4uSSWUOwwlJRVF4/GSrXPdB7/oI
 BECxFOZuEJPIv05AlQ2m1Yr+hSeiPAw885+Om46iNBYtzXouJISNA98IN8b7ZsORGLHjEEuygql
 SQWDv+68Ras5CV7hqkHyDGEzEhFz3FDhFOLIdAlUKGALiHAyRWB4eBxHJFzzRcabV0C9JHtoztZ
 eZ7OTKjXk1uc2QA0wScznosrmj9bG0Z88KoJcBdorIzyA8Vqwlei5HE+j2dUn8bcEQ64yB0sVRd
 PU7H2Ukic9gYeyHkwg07CuLWp2n2fsvGD+T3qiXEyhmFjdqmEjIb9gqpQRfRgoX1l+PUYaeekGJ
 u9PnNNpSy7bEdPCPeOHWDXH59TvuMsFN5dOixSiXUhLmk=
X-Received: by 2002:a05:7301:da82:b0:37b:2731:fd7e with SMTP id
 5a478bee46e88-37b2731ff62mr7986788eec.2.1794863803525; 
 Mon, 16 Nov 2026 13:16:43 -0800 (PST)
X-Received: by 2002:a05:7301:da82:b0:37b:2731:fd7e with SMTP id
 5a478bee46e88-37b2731ff62mr7986774eec.2.1794863803013; 
 Mon, 16 Nov 2026 13:16:43 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563df84fsm72451589eec.20.2026.11.16.13.16.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:16:42 -0800 (PST)
Message-ID: <e7ee8fbe-8c59-4e17-8112-833afca712ae@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:16:41 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/48] hw/i386: convert machines to use AliasedClass
 interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-16-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-16-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX0ZZ1+aGLMOyL
 qoO+ANBzEPubMagbXakC7XYHq2K67ZaoqM9TOz1rebCKfKtfuPvaZW0E+phDrzxaoczhcnk9l7T
 UBmI3U+81tPiLew/XxrUYzJMHwpARkE=
X-Proofpoint-ORIG-GUID: 6VWd6j0ZnqzNPmfiERrq7EznJTOAzU7W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX49APJeGWWtw7
 3FUojllRs0Mexc6zs+IjiTXzsyMtJHxJlwmY+iKiarc+BAgh8WrkhiLabiVJ+bQi6EA08TsC6zE
 8qn2NVflS60EOdn4dovCBMXB4nsg6U2x8I/QHEuZlCn+SJyE/Rp5kWPSCDpIuGl4RSImeM/xfO4
 h75HI605XPlqge8jnnRJVP/BJYOvF+m+G5uYDA0zMQloLZDIExsw6Nr5eXnPX3qgXpH0qTyEYV6
 zlAYIXMV2UU0YsuDm8g6PR2tO6g+bXQRD8PFb8CssP6IKibkBK4IwU9Hoxmn9CS0d+wPMaVhdqa
 E/8lKg+wwdMd036oVEdy3TveAfKvFdRWb8Hn8yrO50mbXXDXNcepnQ//6Nzj7pWL9HjrPYzdSLS
 sD9Rlua4wxJCCIWlJzLpFFij8KzmLQlJo6PSFdm62TXERIfbi1jy7lRhsmhGlNo2s/zD86uCLRu
 HkfNdzckR8anMQ391/Q==
X-Proofpoint-GUID: 6VWd6j0ZnqzNPmfiERrq7EznJTOAzU7W
X-Authority-Analysis: v=2.4 cv=R9uWitRX c=1 sm=1 tr=0 ts=6afb72bc cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Kqo8LxV5-QPNKTeuZg4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160084
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> Stop setting 'alias' in the MachineClass and instead set
> 'aliases' in the AliasedClass.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/i386/pc_piix.c | 20 ++++++++++++++++++--
>  hw/i386/pc_q35.c  | 12 +++++++++++-
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE638606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FhC7IDG4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DiHE8FyQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVYOw-0005Hq-M4; Mon, 23 Nov 2026 13:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVYOu-0005FO-96
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:04:24 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVYOs-000741-LD
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:04:24 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGGuq93730280
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 18:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gHxg8EJ17YU/AS5RJnXjuyTSPYTJ66JsOkyqEfxdBQA=; b=FhC7IDG4kSMYQ022
 U9c88EdyHx+tX0VWKGBoiaR533fIXW/31yxtAuMAbUDqOA30xn785f/NJ5+v9Ehg
 mFR31CxHMN+KngGw09fAhQ84odXAiuCBgIdTSzsqQy8ThNkCDJE2eTmx+D2Os7wq
 MhO90GsqfFljzrPF/+6OSw76qVmulA2b9dBOKygLxJ7xVOV5huSiUpvIsHlCcTFK
 qeAkuVHWg2IYWkgJV90TnWeeTAsV5jWuxanJiKE4kyR7nuywXfRPRNNdu7s64DX6
 Nbu+HfLoSlRlzsDOfu/TgOxefe2wME4nG+Ck6ozxN1XucjcSTXTtx6nilzIQBioC
 rO1aeA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fyd2s9n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 18:04:21 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-386a0f79047so3211386eec.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795457060; x=1796061860; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gHxg8EJ17YU/AS5RJnXjuyTSPYTJ66JsOkyqEfxdBQA=;
 b=DiHE8FyQ/zXDOdz3NhfNtrbU5aiz6mPUsKloV1KJdh4MOY3k+MbCsUsSHKTT4rcTYY
 u5X4tKzyln3N2n4h04uoyONe3f5a85Qb2g0s1R6vRWB5hoXSSuTfRGXstKKcWOWwxTo+
 NNUEh6IJ7g0CeWP7mNTzxrkVSUwgPkn1TKqQz5MQfK3Bu2XLqEFqj/Rmi/oeVxIME502
 NBLH3P71t9iA5YUp4RntrvOCKiLd3lYC84wv2UrX48lf4utH7cU+szp7y1nyYBDPUgkI
 u/va9cE34N3WTJDa6C1jjbNLtRCkdP35teSnVexro7gl3vebbLtCkLXvyI/17gvAuO+7
 enCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795457060; x=1796061860;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gHxg8EJ17YU/AS5RJnXjuyTSPYTJ66JsOkyqEfxdBQA=;
 b=r4bR1BhB3serRu/8o7CAe/q6mmFfKmktXk99wOJmv7B150nRePrjyg1F9BzcO+lPzI
 n4eLZYVuVhpMYpQuYD3NEvRoijKWUO5O50uHf7HMaFq6IUPERNd6Btd80002p9ZXcqHU
 CzBU6DP9XBW/lyOND1XhAYKLcPLMVRT/AJQgU5rXWY5XqyL/gp6F+cMUDMofeBTMGiVb
 k8fcwWcSv6jPODDh0eIVMF9pmGm3Z5e1HBqQY7QYUh/1glkOA74ZQ02RvB5zYgMYGtCp
 gWcnmQ5lmiAmF4RUtBJrTNmWDq9gQtko/tHatHE1y+ixN4ch8mf+djz7PP19qhtrGU8k
 dKjg==
X-Forwarded-Encrypted: i=1;
 AL+hErGxI+E1XQRilJ/U9SKTsVFyVdb9WtFtK07W9Iax87QBtbnTrM3fB0Qvv+902lBV2KJq7Ph/mXFv2siU@nongnu.org
X-Gm-Message-State: APuU4Z947mh4LrQBEyMRj91XpvXXAaNtNikaU+XPHCiVdVTSLb/dJE6l
 0elVRtC8kecmFZhJqS8gyLIvmogZwB9FojYwg4tT2a/kso6UMTznqzENgOe+apQioYJ0ca+q8a7
 irKULB/pyU8cGrK0z4RMLhTw9EwP3X71C9h6ZE3dofO+q9+2AwJ+8MIYSjQ==
X-Gm-Gg: AZFdTZete2fbpCyjQVcYl3rOvOIPVO/Y0OJH9I/ML3pp2I9nLhjFQGMzP8thS/3DLkh
 LIOONBYM0A3hTbtx0v4AGjS/Ck9aWsC0I/IBYQPA1oarUKKzmCJUgsX0vUf/aBMDD9SZFD7rUBl
 KuKdwGAeQaszkgqgffBFIsfIT0aJ3Iyju4pZwBCJzTkr35+ma0Eci4c36qiwCwf5qWY8l+7niRh
 NhMxoFOqiXDxhx7SkKQLdWL/Jv/Fs/DaSK6PcUgGFxTdNWCUFH6a81skm6y9DOfEKIsiAJq7Nuy
 ej5LC7uFL3tXCo6qFWfecK2zIoDIjWBFzQCQcz8ibAj833xIXzAkII3jE7vKCuz81e5f/vG83sF
 LPhecFqps3S8eUCLtHzof86NDuvjTVwFU/0soZNXtYJmDbz4BgE2kVmNMEQXLEBbs9yXQI/yOa1
 QvDH08W99Ir2XpUq712idPJ35rtPzXdiSRzkTTe9O0qlI=
X-Received: by 2002:a05:7301:4281:b0:386:a193:9afa with SMTP id
 5a478bee46e88-386a1939c38mr7996351eec.11.1795457059488; 
 Mon, 23 Nov 2026 10:04:19 -0800 (PST)
X-Received: by 2002:a05:7301:4281:b0:386:a193:9afa with SMTP id
 5a478bee46e88-386a1939c38mr7996332eec.11.1795457058974; 
 Mon, 23 Nov 2026 10:04:18 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd40c5sm44407703eec.10.2026.11.23.10.04.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 10:04:18 -0800 (PST)
Message-ID: <62093341-5e29-436c-8e05-85f982dd466c@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 10:04:17 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 v2 08/12] hw/hexagon: update the glob-reg vmstate
 ver
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
 <20261120182031.560481-9-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261120182031.560481-9-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JNE38_4ki3jwKicf_Xd841R4KDxDPR1K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3MSBTYWx0ZWRfX3HivvtFjj+Dy
 0He/ZS5f2Eonayi4H0z0IFYiirOZ1zCu8TR/ATCqPIm5Qy2BFD9OUIoflm+o4QA5R89D8/Mr028
 m2YS6mAsK/LMvctGHYt7i26TwFILt4EmiciVquKR++gcVmZoBfxxZvwGpu+ut6Vpb9tiXhyQMbW
 70zhQUs5oI7WKKWnddkXbfRpskrpvsgTIcwIJXy/c4ylhVSIj/kwidzjYOXW9nQux5PLSbCtWDd
 ItgaAEYbCPkLMnu+qqtdHJ8JXPeZdbGmX8xQzIGEYFqJFej8mi1D+r/8A8ioc6cbXw/K0uviDz6
 +U9/8Sad0HRAm2c//Wt2SIvm33F1IDEcR3KlyCYdArduM/xNif89WBO7/eJfHQGZFl6xCY4jYJw
 b9OwOwGzVD8EvcXv5PENwZ+zO/rj1AFXQ7PN8dXoUcUp1vzXYXRqbC2o922UHIbf2E0CfGbmDDg
 N4o/Yc5fcNpvQT/1/6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3MSBTYWx0ZWRfX6bKOUT3fSVM9
 yWDrotyDlVDJ75OwJExVMN1R6oTzCEMVeCuKqqFwAtPf17Q6AJgV6Op+BmxRgsa5LifGZkO6U+n
 Zl3Hw/CqDG/XksAAkA1TMu3uesItiss=
X-Proofpoint-GUID: JNE38_4ki3jwKicf_Xd841R4KDxDPR1K
X-Authority-Analysis: v=2.4 cv=Aol7T+9P c=1 sm=1 tr=0 ts=6b048025 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VfCcrfzJFBYrVRP649QA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230071
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

On 11/20/2026 10:20 AM, Brian Cain wrote:
> Since 11.1 the layout of the migrated global register state has changed.
> Several regs were added when the v81 interrupt/commit/cycle count update.
> 
> Raise the version, and the minimum version that is accepted.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/hexagon/hexagon_globalreg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Is migration correctly supported at this point? If not, we might also
simply leave it as it is.

Regards,
Pierrick


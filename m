Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714ED606A8A2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W3Qpudz2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hgAbVdxQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3iI-0002Ct-BZ; Mon, 16 Nov 2026 15:54:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3iC-0002CM-VF
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:54:00 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3iB-0002NS-3Q
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:54:00 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfEng611757
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MQuqhirjYoIHfQNki7GKyZs5s1xP5P/HQuYEVKraS+U=; b=W3Qpudz2OQtaGimR
 fBYX1oeWpQy0Q4ejPvRBF6LSAS0aHPnCvQfW0QhcFCI9//6TiN3OFU5jRFCtzw0g
 NkL3Ofm5DaN7SYmVSDLw/0zegGGXZKGPM4ClQw9a1aVEbHs3XXDP95YZMd2LQ63Q
 U2RKx2/3E4CMzSodvTwJjkcroDfjq68lf0WyqJTKQW+3FCIbg7sNPH4H7AFCAIrU
 L0N99hVs05DjxtesrKxvLpvKJiEQoo8gX/xzslFCyGifG/UN0nx0X/6AUxEsEVm0
 6a9lMok796p8WlrSB7SglXqgjAzbrw9or1qLfQfhuG0BrkyYrxj4QySdhv5Y1ebi
 erTXNg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyy6gjn99-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:53:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so6011295eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 12:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794862437; x=1795467237; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MQuqhirjYoIHfQNki7GKyZs5s1xP5P/HQuYEVKraS+U=;
 b=hgAbVdxQnW6Doh4oQx0nGJzTE+ayJ1Jr1gRYGmWWxADii/JZ1QQnO+7mkDW7Wrjyn2
 9fq9zZhjiIGcWUffNPXvrtL4VJfELGcA7OfQMpqJZPNHsM6HIEhFOFJ8arH1uqHFmakj
 coBtTNzPKEbQDqYhyxVz8GXCIszULPNPsj3M6Y2ywYUTcKmkUUcGqkHHMpQdWDaEhlh1
 uE2LckM968z8oWnqYY/2HfUg6jHxfk+y5oTy7buY9BzhouLKc4I3en8OC0v5ZqDoBiZS
 U9ncjNwUIANB/Ot2/sLwKsNz6WRAwhKNCOIRvlb6q5ZJZAGgyGuWgOw7aScLq6OfCYN/
 ENlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794862437; x=1795467237;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MQuqhirjYoIHfQNki7GKyZs5s1xP5P/HQuYEVKraS+U=;
 b=Z+f0dhlvbU1cQYh+tSjaDHDpV/WgCdIFpiyyQwj2g5G8zR5cNsdgFiO+G8CtZkUPLQ
 x1jGSME6c6wR1vQ9FIzGsUhBAu0VC+LoAEBkzm4kE0M32xsxA+JD77KQOKNlTAWAzrey
 8M111+rTIK+6Wpeer+35mt1zCw6+V8zY5FtC4xzPCnPGdCeeRy/cuEBn3vXsJ9j2yW7r
 ExoFaa1YJ7z7ZnO5kIj62x/N2mpVIlBhTN8355d/dTMmXMQGgIc6AVscgBYoz1mOI/cG
 ZQ4eeEUvbXUdQkX4UFLsjYBYZHlotj6VVx/sat/mpRNWz6F+YtSZLaR/ZOF8qFWmxycy
 QHmA==
X-Forwarded-Encrypted: i=1;
 AL+hErFsP6xOmqksB16BUyAExspqH2Fea3o7DSeec6twjqm/5lF9z1+edmRIaJfjSY49chw5fylYcDJXmAIl@nongnu.org
X-Gm-Message-State: APuU4Z8R5qCOBC8vJwbx5uUECj2zQMZuoxcPNlL846gnzjWdPMFwsnoc
 TLPhnotzql/IAyQazhY/azuRPSqn054HhkrQKrJw6gY84As/jKpJxy5tCpB1i/vx+SvKQpsXSeF
 sBx8OsARJ/VC5/ZoqaGhCyFZ8RvbzsPPB7vKQ7mFUAKUErUiZ82bQlu96JQ==
X-Gm-Gg: AYBFou1Mxa6NHyL0f7FsFKyJuXGyn90kVakbr4i8wyCqixzatySAYN7mQs44WwOPs95
 pz4p/KSUw+N+fgbiExqCLnWhzdN98VTazz6nL6O7c3dh7/M1i61BZpARsYvSdt4N/Z0VarLEf/y
 QOBkxri+1x9ssU5LPcZKlKaZnBq0Z2UusHfFcjHdql0T23R7/CkfP6IIVFWpv/okgV95qU+UGlc
 3HyQnLrNQfl6eAHrG86Do+e+GnabasXPS7X9ioKFiBf9PTZLzCy0979qJI94GRD8lursXpEu6Of
 WQkTJEUKZM+JUqKjqTEXmubdZHCAqmdYAetTP+HWVxdNGlXWSGsUKhC46T0+VIEClmQX2MsonpI
 4gGtn+Q8KV/P3mh/pfhcFa2KAZ6QoB5A8+WCTBL4Tb0OOnBI4YbvcTnIZL/rmEzWNmoOdiVExe8
 kM6/PzX4cDmrgRW9DCQEPvJmJK47ch11LazZKpuMKPIrU=
X-Received: by 2002:a05:701b:418c:10b0:1a8:ff0b:a4e1 with SMTP id
 a92af1059eb24-1b5030fc737mr11586193c88.18.1794862436464; 
 Mon, 16 Nov 2026 12:53:56 -0800 (PST)
X-Received: by 2002:a05:701b:418c:10b0:1a8:ff0b:a4e1 with SMTP id
 a92af1059eb24-1b5030fc737mr11586173c88.18.1794862435871; 
 Mon, 16 Nov 2026 12:53:55 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50316e195sm39404046c88.8.2026.11.16.12.53.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 12:53:55 -0800 (PST)
Message-ID: <a71704dd-9662-4e4c-9b3b-46915bdd4a3c@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 12:53:53 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/48] qapi: report multiple aliases in MachineInfo
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-8-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MiBTYWx0ZWRfX5hsjh3woV3nx
 z6KNdsb1ZpI1RUrdH5uez8lLCK5sXwhWrm5VtGtJlfg/TPzaAl3eaVQNY7zUTU8M0rK8d9NFSFq
 GFVdV8LaMv/A9Yl00yMiANxpwecmVMplFl9HCVY0KvI8Y+Hht4Ujjq+rSC8FlPF/Z/X63Gn45CU
 85g0JzR9UkZnS/sBhDJNVWSTl3DiQwPAs6iOe1Nvwi5EOLXSmXTCMWcJvwtj2EB+QaF8gx0EqoE
 XLLbstV8bUpBanLXlPngIeYN74yZsqfwsu5Dj9Ywttm5DINYtMFA0q/M+Awn2IU9UYw+2xLCMdF
 ixzhduDn7mIlVKrymN3J0BPGLo4eUgdn5I0Aop6PnfTacC4eYcJuGLoqwAGb808YUrAYme0Pd+a
 PmE0wo+LD6z5pQcWFFSZ6UxCOX552T50OPlbD8/yQI4Z99FQYW64DFG9xZGF/1VtDoeW+LqT5m1
 vniqcNj2XGhdYjRA0HA==
X-Proofpoint-GUID: Fu4zkf7wVNVyq9fJsB_0ahhSljTelE7o
X-Proofpoint-ORIG-GUID: Fu4zkf7wVNVyq9fJsB_0ahhSljTelE7o
X-Authority-Analysis: v=2.4 cv=D/DSufRj c=1 sm=1 tr=0 ts=6afb6d65 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=qNKvs8QdKPWPAKYQtCgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MiBTYWx0ZWRfXxRHuRZkx/MHI
 fzf5L3ZOXxtxQPwwtYLThS9QUaodmDQWtAPU7akPv47eHo0OcCD1TKKEJzNE6XqT9YxSgXv2OAC
 X/pmEjcajNrml1u5g5LYUOEdrgH8++s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
> The MachineInfo struct is extended to report the list of aliases
> from the TYPE_ALIASED interface, in preference to the traditional
> alias from the TYPE_MACHINE struct.
> 
> Initially we use 'alias' to fill the 'aliases' field in QOM. As
> machines get converted to set 'aliases', the first 'aliases'
> element will get used to fill 'alias. This provides backcompat
> during the transition phase.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/core/machine-qmp-cmds.c | 25 +++++++++++++++++++++++++
>  qapi/machine.json          |  3 +++
>  2 files changed, 28 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


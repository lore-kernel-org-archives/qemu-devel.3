Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344BC606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FjDloZTQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U0DtH05x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3iz-0002eg-8N; Mon, 16 Nov 2026 15:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3iw-0002a9-TS
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:54:46 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3iv-0002XA-6i
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:54:46 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfUHv3505592
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z+hnBVQJvtzFm4u16atbmOEYJTpn1iffe3L213FMLVM=; b=FjDloZTQHbTW7Yc7
 WSQCBg9kNYLzmmgvU6vG3dzZqoSQ+YqLvmitAeWy5paHnT3ttZXyX2AHlFxXyi/i
 s8ztnc+9ko8KGVok54PnnNGQ/WZ5ARy4Ur4F1qX2Ogz1ajk0fEc0VeGVV3sKLnG4
 aotcsUzLm8AFaiBxuaCvbCahlWSMRdkYPOsxKfAhauEuk/EUdC78vLDbwr91Yg/B
 TOXZ79Kr9cBMZ1iyMMMcJlmT8NCcotvdmUgBGQ0VvXkeLsmV0giV/FUzgms7rbiO
 CrqakGDvGtSDNys893pteSYD8MoTI+/GfSK2rSwXF7vIeYtlf3zw71cNyCMB1Dwt
 KPHhlA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j038m9nkj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:54:43 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-37628596fc9so10335563eec.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 12:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794862483; x=1795467283; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z+hnBVQJvtzFm4u16atbmOEYJTpn1iffe3L213FMLVM=;
 b=U0DtH05x/yFsxdozO0VEq7SW9sppYzr0bXbZ3SZPX87RR3Uqye+8z8a7/oGqMXRHkM
 lkO77fjXo6+xJK5hp6Lz6E1BFShw46ccPYPftprOt6i1nCxFItjToh9LgeS/OgCYvH48
 Wv5s6tqreMLKK3zNoeYc+c3wX0lesM/SLnG58VRHSoRPWZPeOVSKSx0fRZ3OAlSQgqkg
 3cK48hQZz8ciDdLV3xOVeVu6cAkgJQ9DNAGAQ8S66EYcp0AVyy+5hk4bIaNXplyaCaIR
 veUHtqVYhm603P40tBCP8LRe8HUzLsuxdHLVpH4zaq3n7YwecTFsHa92pgEY9SM6Teqb
 B1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794862483; x=1795467283;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z+hnBVQJvtzFm4u16atbmOEYJTpn1iffe3L213FMLVM=;
 b=iGiRrXJvcBP1tNZJyzrZJLcMUfUQl+zhhZ01OQvaMwAsr0D1iU0vxKuIeAtAuVjyAN
 P85e3fD74+5R6Y8zgf6nrdV6mfTtTMJRrp+Pj/YALtF+UFzOcN29f0KEyIF1DwlOeGlo
 z/9utLXw7W8sZmy/VZXBsIpRt7r+b7bMpoxCqlHlrREhzLKo0Fh6UsCSizxKi7ZcWW+u
 HnbcwFaWP2OpYdYafRIkmC6GMpEDf5BbyH5HPZ7ZRz9EAy1zztQFCH5WvYLS5rAYo6tM
 WvWpiMMx5oXKbPejqQ1CvrxDTo/pIk8EPyNtDDQElqL5lK1ZI8/6b6hAsp5CfUybCtqr
 oD5w==
X-Forwarded-Encrypted: i=1;
 AL+hErGg7U5wGDCU3hKkQXJcQS42geJsCLw0ZNJkhhOYSmZyKt08+anlL/glbqR0F3K7DcimQhYRESRdCGyU@nongnu.org
X-Gm-Message-State: APuU4Z+/oPXY527KdZm/6EgM/AzB27FqWittcR5DjMlkpGEazE4gsRZv
 bWW7UQs7+u1lsuBSgXTsutZPSLJdlojgi6fWxyRZ2h9XPwytrpywqI1Eqm7HFmgiHFUD1AvFaCA
 7xYZm4jwD8md5MZ0AYf90ou/8YB9mEIjWAglswQMazlDowDm5WRn95E+eOg==
X-Gm-Gg: AZFdTZfGhrReastPlEO9eYkjGv7vlEOHJe60DRNQhYfpulb5LVgBy2bT2IeB3qDiEhB
 c44bK7vXRuOnsODBYYVnEKj7i9a/K3Fk0Oqqsj8pQzSDuteCgG6zi7brRRo0pXvIfiUcP0PeDH2
 39v7YDwfAEo/g3bDpWMnaCy1bXPDjTL2Af7Q6ROUfKRTKLxCD+ZpxIVxober42hIyY90to6tJQc
 hIKSqPar0QEAI4c8w539TJbcgMfqMMagE2gubt92eoL2z+9P9PlU2L7TX+r+ZmnpUMnPJ28ZZrE
 D+1jJDUak2gpQNV6dgZm1hhCz+PFt6lTi+aFSKHysYk5lc1KzGyKS8K19HRv4bAY1bgSxZ1eVhG
 JWLNwpzKmFeZS0ONVfOZSXoltZodIS4iST6BruNx2khoppBhjAwUVWVSezkVPZN2q/65IbPA9eH
 o9bSJZQwvgTcKob15oalif783k33jRbrfkTNs3AsH83L8=
X-Received: by 2002:a05:7300:72cc:b0:376:98e7:eeae with SMTP id
 5a478bee46e88-37965da98bamr17219680eec.6.1794862482532; 
 Mon, 16 Nov 2026 12:54:42 -0800 (PST)
X-Received: by 2002:a05:7300:72cc:b0:376:98e7:eeae with SMTP id
 5a478bee46e88-37965da98bamr17219636eec.6.1794862481851; 
 Mon, 16 Nov 2026 12:54:41 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-380e031f3e5sm3815511eec.12.2026.11.16.12.54.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 12:54:41 -0800 (PST)
Message-ID: <adb89d7d-7a8c-48e5-83a2-f90a2030d979@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 12:54:40 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/48] system: report multiple machine aliases in help
 output
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-9-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MiBTYWx0ZWRfX7BSAhhwFcPDY
 pMA8OIRvsauoPXWhpUjUrH8IZnc2d8bcEDubSCqHbSlTnOF9RzHS4aiALgx/lEVF7hQ655dWvR5
 k3QcnTeLpP42fbJ1GZUphtCB2azN78miJ27EHAaBCYNmL+02oghHo6yQ1k0VKK/H2SfnYyF+D5Z
 ipRboHGsN7x4A2M6hnUEP4n76WRWJcSHgE8wGCoV0qODn4Z0xYaWrq1ysdoNQOcoqnsK9YSABM3
 mQ6qAwU51Xuz7J7atJMp3HeQLwDzATtmVt57Zi18KnagU0RTIj8cDUZItfkwA4BuDCJxA8K15Hg
 +lcr2OZmHiopdoynANtEXJbSabIiEk+OqHwhChdzi3JwjAVzswtihOmsAd2BF00Ut8r2q5m+7d+
 C6iSOhVk14M5VryhGe0jnJf1lEcDu7sadq2WioJaWDi5Q38GZU8VEeblWTf8B3qrlvFgBal0hxO
 mMqxpnFyndJmcr/nt7w==
X-Authority-Analysis: v=2.4 cv=TckDJhQh c=1 sm=1 tr=0 ts=6afb6d93 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ZRd6skjOBLRtTwr6M54A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: Ik3uBXcuuheF-DuoJpOA0v_KIG1eZ0vc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MiBTYWx0ZWRfX6WN99HyP+vT7
 Yfa25TDMmiEghHD+FjsCDipXTTml8F4MyU0YLtSUokEjf0aAse1heUqAkaebghb0Bw0/x8kGD70
 AUInktMeICmoLHvj6RUigCXOdYiWBvY=
X-Proofpoint-GUID: Ik3uBXcuuheF-DuoJpOA0v_KIG1eZ0vc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160082
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
> Update '-machine help' to report 'aliases' from the TYPE_ALIASED
> interface, in preference to the traditional 'alias' from the
> TYPE_MACHINE class. It is assumed that only one of the two fields
> will be set at any time give a given class. Shortly existing
> machines will be converted to the new approach and the old field
> removed. '-machine help' output will remain unchanged across
> this transition.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  system/vl.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


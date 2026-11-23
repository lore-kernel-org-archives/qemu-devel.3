Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B57606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kPWuwZel;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SIqL6o8w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVYCv-0000Zy-Ei; Mon, 23 Nov 2026 12:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVYCl-0000Yu-5X
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:51:52 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVYCi-0000Zn-Tp
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:51:50 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGH8Vf2769576
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pgzXZxnZ3/dpUcSiwO1DINuujUrC7FeI9WnlIPzPyI0=; b=kPWuwZelN8/QYxTW
 TM1lqvUedjT9wGKOBZSRLatbd/J2T6dojvvbgLlwBMmBxrxmv7FPem4yp51ZwjZI
 dl5rOpxNR/p7pHljMeYM+lNvcXKlHcjh+A9uYwV9TpNVht3nSw3wHcSzy55CHb78
 HaupOJG/YfRo57LmeEbnbHrr77QN9oMQ9ijUmehuZDcny9BHjah+4TKwgx9GKJ53
 KRX8T0jJLUPU2lvpF0XFvxe6shQA3N6PNUjlgwGx3XNptSQqOqX9LjC6H5t0PY4e
 bTm4ZkXaxacUHFkDn8QEYBAZgsv72EZMfKhCHW+o5vH9okFXLz7NgUvKEiiMl6Hr
 FnA4Kg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1panff-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:51:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2f053f9631cso37949755ad.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 09:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795456306; x=1796061106; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pgzXZxnZ3/dpUcSiwO1DINuujUrC7FeI9WnlIPzPyI0=;
 b=SIqL6o8wY83xlbHQCPSnuEmsZY7C0Lq5R+CwwzY5lW7dYgB36y60Jq6GWvCOWC9fhu
 X2us1P793ODpH00tgvCTkhjKpjThdI7f2u4C6eYP4UmEWZUfZ7HffsFS+p/E+w3PCrvA
 7qDdILdE/J8oTFRm8TVEPyE8Zr1gmM62KY9fY6A9Bm5veJinsKqo4W3X2qrRAJygkSyE
 jYGXQGDubF6XFy6YwcfhVPy3EruWNn7ZfhIHFHsdpCchs5R1LsZmIK9M9TAu3VOjMC1l
 s063H56frLQy4j9+5qet8IGvbPUa2DQ24kE1oi8k6yt1050a+91C1WiWaeRDOnb6Kzm1
 nXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795456306; x=1796061106;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pgzXZxnZ3/dpUcSiwO1DINuujUrC7FeI9WnlIPzPyI0=;
 b=LwP8LsyhmLGFEU2PZcxPuOkJU8Q0uKk2+KOyEwVgqFDzvWB+Pa/pi80T3jCXT7KJrr
 hhKkOx4xjT+dlE7hrHjHrxUJYbEbsbedGVyeHeEWMB5KkbnJORkymdTQf1ri9+8DzxgJ
 lEnQrtPcXcr2mywmJE1M2chewXt6O8sD2NAUYdverY2faQ5+P18EExMm2VhDFPyL55FL
 K7eHcc2eNGEmyRlLXJmo1uyp6IT3yLhxctMEep7/fhxijTFhVdJuPhnzxDcS1PWdZ035
 WMg3eekM/kF90VeI1OB+bhI+gI0O5neRg+bUWVIvorNYNfXpkcWrIyuUgVHEUCEcyzF+
 iHgQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGR6h2r2A0A7hgTBztT8/v06/cSekEe6/i09zb7TdaBqqa0qlnUHTKY1sZsTBcL9t/NH94hdotSXhch@nongnu.org
X-Gm-Message-State: APuU4Z+aZhn5rcf0LV9z8JKa+xt/2Gd8ikDCixxXhjXlFN/gGR94v+DQ
 p8C1dxTUUpcCmAQG7W3n1CgWbD9JAtU6ZCxQx6UbZt91NkoXc/fHEeqDhL5HzCY2SvcyLcr13wk
 wFVyn5ylac83nm9V6JNMCEH1V14PkVDiU3bvvxAMmqmh6y3Kkq6i1YRV0cw==
X-Gm-Gg: AZFdTZdNWWIAbPfrBCaTYt5oSomnDoIP1a/Hum9kvwxmGyY0i1nPpzLaTdPHPWQm1jf
 kan++cA8Smuc74L7ZkBCSnHqferV1ZtFM2lCWTyE9GI1COgqNJPZWGSiOGSvLsQ7d3jRj+u24y7
 zfzQC9v2sGMkEfahWJPHKjp5zXsjA+CycvIaSsazV1BjfkxxsvotVDY5/V2qUXmUuKgMBfYWExg
 ykShscaPUVVHXo/UOWUgCDNrm4WiEnFEaLLzjeebRi5La05hcXluhS4VxzA33VPdww5RCge0zqv
 OeZkZGxd2FJg8dwsn8ofRN4BqbdgRsLgmHZsT8KM2UW644v6oIY/lmQpFBkt0coCoNSWQjjdtSO
 4lvh3uHcxY8qEfynGMpfBDDRn9gSckp4f+XnVppx7WO+Z4IIkrxOWaYn1j6T9Obkp6Vo3un9AJO
 iIPWr9xFQ5CAR/i5v2Jdew8Av/NxBiBTF5KWVppoFcqtk=
X-Received: by 2002:a17:902:d590:b0:2ed:130f:869d with SMTP id
 d9443c01a7336-2f03f236133mr122106225ad.43.1795456305667; 
 Mon, 23 Nov 2026 09:51:45 -0800 (PST)
X-Received: by 2002:a17:902:d590:b0:2ed:130f:869d with SMTP id
 d9443c01a7336-2f03f236133mr122106055ad.43.1795456305163; 
 Mon, 23 Nov 2026 09:51:45 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f04f6049dfsm47474365ad.19.2026.11.23.09.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 09:51:44 -0800 (PST)
Message-ID: <e0ebccf6-09a1-4a4a-80dc-3fb60e489f42@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 09:51:44 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 v2 03/12] target/hexagon: fix get_exe_mode
 assertion in hexagon_stop_thread
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
 <20261120182031.560481-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261120182031.560481-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3MSBTYWx0ZWRfX5c9QrMOSPsn8
 QgQgNwspC3v6jX80YopE2Ny7G5ZXEGUrOhwToWg+qpg+EyEOehg9Ir8Ro9/zJIOVHS79iVN0soo
 h4h7NZQWqP1O/d2NaIlBwQHbpQkjUGqu4UQ3weR0ipPL5qJhX6oI+IH9R9ItBGF8qN27VIoKXyY
 HZgCQcC0LXSHaMmUxyBamBKZ2Db7P2YpxknlGVbfXids/0Eq9KTU9AV+AD7MfJbxr9LRAuqA+zF
 3qya0ZEUZKePrP1hCL0z0Iic/bXNCcr/eJZ8g2EgUNHCzETRXWslVE3a7c2bpUTC0m7O6USKQ95
 k/Ta84KG4m/6jZrVI4QaIk6f2iMBH+hp0FcU+RIwelQ0bK/nRL2FwAfXSH5OrAs9KuJwK42lHeJ
 e7ld7kMYbK0xzSgrW9IL6vbF+IZMSuwB6NHeuBmsOe6ov2klIbPaAUD24unbshCdbUSZczJniig
 XIxkj296OA87UwTF2Dw==
X-Authority-Analysis: v=2.4 cv=AeIkjHXG c=1 sm=1 tr=0 ts=6b047d32 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=4JachmoQNc6wDeGGUC0A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: VxfB79cqFeQFqOciXq5Ow104JPP7svSl
X-Proofpoint-ORIG-GUID: VxfB79cqFeQFqOciXq5Ow104JPP7svSl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3MSBTYWx0ZWRfX/S40AGun0ZyI
 pN7KyePSWUD6n4XgsnJgwPMM73WodMf20QZjtGJ8thHdcjNC28AH9fFV46qAbUbDd8Q11X1qlK3
 n4+jFvsP5icGp4M6CWPTKuPOBq0fmCA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230071
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
> When a thread in WAIT mode (W=1, E=1) executes a STOP instruction,
> hexagon_stop_thread must clear the wait-mode bit before clearing
> the enable bit.  Without this, clear_enable_mask creates a transient
> (W=1, E=0) state in MODECTL that triggers g_assert_not_reached() in
> get_exe_mode() when another thread iterates all CPUs via
> hex_interrupt_update.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_helper.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


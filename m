Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4D6606A339
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ed+9es7W;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HtII8wn5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT492-00068b-7n; Mon, 16 Nov 2026 16:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT48k-0005xX-36
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:21:29 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT48h-0003Rm-Cg
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:21:24 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJg9ET4147707
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5ddsgRZuGTAaPwZ7oJP2D/ZK2hK7scXC9HX1lx5gKN0=; b=ed+9es7WFH6T8dUE
 EYf0ENI0WRBsGpXsqAFFYn3eS3hsye70qfrpT1VDpMF45MHTrk7BV0iH13HmF48m
 mCsnGf3sIo0P+Jwfd+iNEYSLBBNjAhqYdLEE0Q4WLwNlNLRfpgnDX53mk549v+Ip
 2HhXER2l5iNu3Zld9xps2LpPtJ+h85Q2/vMj54g29EgV0fD9fvoKEctvPB5EL/oY
 3+s5wrbdttP1D6l9nxdhSPB0beBgnMhJPWRc++gV2EmJ0Qv6L17wBVJHWFCLxiMW
 AaI1xPJax6mB6mZXP5RZylxRS2lCCE5TfFsJZXkhgyp9TFOYpOorIvlH4Jy5l9fE
 bOPYxw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j01f824jv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:21:21 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139b62317d0so5580048c88.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794864081; x=1795468881; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5ddsgRZuGTAaPwZ7oJP2D/ZK2hK7scXC9HX1lx5gKN0=;
 b=HtII8wn53IVaCayzl+0yd6VW/460fFPst4FVD2Oi348YAX0wUG24Zw9f/fKWMCRU7t
 PY2iPnbKG4Rt5TYa20sQa3nNCGTMDarVN1aZJZJL9N1g+aKOgB6OB/kUGk0ScKXnK9Rz
 LxaEifP3iIXqFS1fq5UGbUwAj2W+XYhYHl4AsDng2CoyczsVhCjAP6RvsGbvgWRd9EN5
 JhSnknmNVCsFqeXI9gMOtfTDsSocMXDsDacTlM2MnwxHWuBTWbUPZ9xdSTjg32V/esUI
 bM08wRL5T/V3V7cfRSwTO2Ya36A/9T7qZvA5BUTIaL2Ul7sc7i066qIBRCdnPLxEoMuu
 qtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864081; x=1795468881;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5ddsgRZuGTAaPwZ7oJP2D/ZK2hK7scXC9HX1lx5gKN0=;
 b=1jsvPB34zDleM4DcuSDSgNM8yjKiohuWpxex3VhVL1uhCO55Z/iuQvK+nHU/CY0zQH
 yT2OqiOUlhKdbyGjAMhYNUTEoUB9+1UaEyJJoO30/kWB5D08X8lN+rNJjJ0KuMs+qNPe
 BjQdKds2ZFS6kigo5pru+DroF4QYdHozEToVLDJpMbK2NAwGJEh1PZWZlqhRdyQF0Dzp
 6+7HcjIkj2KWqab+RyALmNaqGtDqXSLj0d78+fl3H+t68vQPT7RD6lFJLTdqDjuFva5H
 mn86cHOvKTLxvhVbwIrlXSQ5SxD7c0ees7NNYcHnJH6Uo+0vZSM2r3Eqmlf0jbXU/Z5K
 00VQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG4+QSYJApfv6jLG9kytGqfC96m4jjbWEl9IiMtZvwr+NfFPoFaJOppvny5so0tH/Wn4//5m0hJvRDi@nongnu.org
X-Gm-Message-State: APuU4Z/ClBN6oRQEBm0zXAbCdwNyo000SJ9AU2bxJxRa53QJz9RjuHJk
 1t7IHf0b/nfc8iZVBSV/0YoSgrmk9NDM5FMwnw1hQ17eZ4AJMb0ShhnimZUrpWIEPxLg+i/9/m4
 M8Y0pCMBqLjqmiNYNOaJ+VLWt9HzmZXMfuQl04lAQv43B5hScESiHK7FK8A==
X-Gm-Gg: AYBFou1+n3DjwxXj6m3+wAec3FqzDf0PdDQy55QPL3O9y74eCx5iwK7y3t4XWAX+fGR
 QKxLl29/H5QyTsSdCiGRFswX287Oa92W417ZwFSSjPlA/3C1GbcgHYYvty6uJSBaCRTc0+dTjQn
 wv/xvV2YqItKEsJxgKRAyGcoClyH1F17mgUtwOqnqjr5NA/izBNoA1XixYIcoTsRAOWjbPhY8Sv
 leU/9ErBnUAADYCe58Pae2ludkl0Nu1PJRTg8nqFm4jlT0FdqghD6pfS7Hwcw8HuGmKLs1twAbF
 t+PSyqYQ+n5Pdjb1XUgSHVkGn16wpZStAGLywiZWcf8WLLdZ3ruHkwpb+usakK1d6ZOzrO8pGF7
 Q9wgUZ/msF4N56wGi4a6ak7vohV2oU/PjUKAv9WULzeF2wNiUdt3QkWVtBpy2TGPkhjHsePA9aB
 w5XCMVZzKhCTO6bO+1W7CrtnctSPmx3Xnhtj0qcLMyKuQ=
X-Received: by 2002:a05:7022:e13:b0:192:e5a8:6bae with SMTP id
 a92af1059eb24-1b50317fa43mr18493333c88.40.1794864080610; 
 Mon, 16 Nov 2026 13:21:20 -0800 (PST)
X-Received: by 2002:a05:7022:e13:b0:192:e5a8:6bae with SMTP id
 a92af1059eb24-1b50317fa43mr18493306c88.40.1794864079907; 
 Mon, 16 Nov 2026 13:21:19 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50319e381sm34746242c88.12.2026.11.16.13.21.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:21:19 -0800 (PST)
Message-ID: <9af1ac55-5753-4fcd-b1bf-b4f250efad63@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:21:17 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/48] system: stop sorting machine names based on 'family'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-30-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-30-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfXzEwIwdG5hfP4
 TzjRMm/yNUFDNoC071Otxd6R4KPltAfh51jC7BWAfNNZ66Z8o6tV2fjm7FUSxRtoR6qgJW0eJon
 6s6pQV9sh19yEZ7HT/hAvidOE2pInkm/Tpp5xfm4mosVllDgL27T6FXQhxTYtPufqqBvGbREIMP
 kA6vQMT7AgNi5hjJgsk7uYOWJmb/DqkE+uRr8Syk1SGNuQltxZNV26pt8HVvWkOT7nuVV2jwsim
 a6gUEIh25TPaYbbKKsak65SOhSqofU6YbqsJJ/owRTLoLb2L4k0pu9uOw6c+u5NgOTdDPg/P2/R
 X6pJivlnVyB8gvLhVyrKxfvndwjvs6G2+7J4u6dewaM8zsKcsCoLgC/oesLfvnX7kAyHXMTURfu
 C57CCrCKBYbIHTpKNRrmso4IxAWXjGy4eVJypBAB8v7f+D+p5K4BRDuZPsu3Rmy7gOArXO7yU0J
 YDtFxc+jK9xbJvWWOWQ==
X-Proofpoint-GUID: yPUng4HpQRUMAfSG5knS-PaVMYwIzRjJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfX3EbJEI6am8Nb
 VJwo1CoeUFILDb4g0agdOYnU7AKVrHyTV83dQokXyAnkgT/pcwgiRPIV9/HbQilnamODjX0rT2Z
 zuHy3wK+zUASQnYL+XMI2XqU6NA+6g4=
X-Proofpoint-ORIG-GUID: yPUng4HpQRUMAfSG5knS-PaVMYwIzRjJ
X-Authority-Analysis: v=2.4 cv=VMpIDNPX c=1 sm=1 tr=0 ts=6afb73d1 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=w2HWyrTekwPz-YFZlJMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160085
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
> Only the x86 'nitro-enclave', 'microvm', 'q35' and 'i440fx' machine
> classes set a non-NULL 'family' field. This results in a fairly
> strange looking sort order in the '-machine help' output, such that
> from a user POV is appears largely unsorted. No other targets bother
> to set 'family', even though they have far larger lists of machines.
> 
> It is sufficient to sort exclusively based on the machine type name
> to get a purely alphabetical sorting.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  system/vl.c | 26 --------------------------
>  1 file changed, 26 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


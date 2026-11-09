Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC44606A337
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BwnlrKY1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SlZb9HyD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHoi-00041z-0X; Mon, 09 Nov 2026 00:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xQHog-00041p-B6
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:21:14 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xQHoe-0005PS-Pf
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:21:14 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A93Kceu2180708
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 05:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Yope51txf+VUEEFEufdGTQAH1eJOG2StG5yr9k/+jdE=; b=BwnlrKY1pC+p/umN
 4z8GIIUgI+a7MrOMGlLD7ryGbUd0IuqlAciilJXYnlsL31imwl/KZLUc2Crh7s6T
 G/eTjnpP2E/aJ0UuzbAOkoFF7WX1OHppkWJMN1CixFZjXVkCZehscPLHMZAX827K
 Z37RaOfWTyt+EJ8j1JX8xu4guaPW+f3c4Ru1A9+1hreco3eeAfqHQGbM45XuMJWT
 iE40Y4tkpqmPDQs1OEOvFjA19LoJau70XqpN9pUqIYVh/O0mZ9wc3yvnEOTJwgD7
 DoKr3p7lulJde49spsM8Qbr5iWfalg/dB4rEY/LLPEr7ymlvWyL4PnxqLwOxOT7n
 FDu3jg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsvc6mqyw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 05:21:09 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so1398631eec.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 21:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794201669; x=1794806469; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yope51txf+VUEEFEufdGTQAH1eJOG2StG5yr9k/+jdE=;
 b=SlZb9HyDakH8YAJZwBQpI+TShp9gQPPIEPVxJor3j5hEV63WwBFufhw6AktOs8Tu6+
 QPCMbw/HDMm1vYxsmyzsRcKJiU5Oy/5xau/21QvgVPERbsUedxL72dK7EoODlcawPcLh
 H3BIZB0UlGtCPVrPX2/zBH1GwNsEJy8Hao+I8JzYpmlMtfo6XWNIHtrBltz9xO047gV9
 o294lh8USIhV4/x0bdi69wqU3NpL0XJX3o6jItmTqnxo2DjNbp7CBenZ6uQUEvTWVDqM
 VzUVW7dGlUGMaUZaRqECmj2gGKK3uftHqHa+x+5TNa/7/pjhnQ6e8Ne7n3XOraIrxPDE
 cadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794201669; x=1794806469;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yope51txf+VUEEFEufdGTQAH1eJOG2StG5yr9k/+jdE=;
 b=d9B0hZCmL1mSpjWsmXSAD3QT6j7w1U3U/H9Nwn/ApiozmJFk7eQr7AkVky9eVZ45ec
 5ova1A9H/ncWHOD7LVXF1xxdVx2MUwS6lxrMCmgeFn5ey7iKFZEGb8n3PBpjkr8HQyM1
 Yg4bPZpr7y2YWfG4CFMc+VPETjDdRA+HaXXe5J7mD8kxN4ZuOps3sSdky1K3CMjH6san
 J0eqD3O+zxqEWeiU/aNApeiO+QF5Ck+Vb8w5gtQQThYudqgxBVtuGJlIRDXETpjZgyxo
 3mNVWy2vsxVG9EAT9X2ZtcSRp/XYigZdvxMTXMjvtfo4tSyQ3bXZ72lO4GUbCyBdCUlx
 EzHw==
X-Forwarded-Encrypted: i=1;
 AL+hErH2n1tsBrITAN280mRSvyv6vo5ohR0H+MVjOi3hecV7LiKTOpkq/BlCJhzchmOltwWt6KToFLVkOost@nongnu.org
X-Gm-Message-State: APuU4Z8IVnLJSH1Os1LDhhXX5I8hCgD1JAkSAkHmJJ9rKsPnee3WRjTk
 abZ47gxTeuQSvwWM9Ordu1xdip4bPmfUIIb2M7wq97VKVn8BabeQQ4UeZNLSIyDGoseDjmwnMDe
 WG0/+fv5xOmpd+1Q35g9Csj/2mtnwRcwtyls5GBfrHgG5CebNQbTpJ+p0xw==
X-Gm-Gg: AYBFou1y/RReqjwjuuGz2ISWfWPFAQDO60fYQlXett5bZv76CfIwbBMY4XL3QirmvbF
 9cgHiRxMsxuax5e2V7/fimml+iKiDJSJyTfkZCX/0i6DfGln0fJ2qx3JJMaLX/qqTBt2xUKWLT2
 FqPBbRGTAtRXMiq+FBE1iQezmB/FM1ffofqtPzZq8nwur1aDqQo63c16y1EH+RwzYSw7ohSQNyy
 PAipJf5Lf8cBgofnMoTz6bBRhDMIS7HD6kvB/O0YrYHs+qwqY2gFlYaUd9kqA17UOXycg+wuu4+
 6OkGb+zlpnyv99FTpbzvUyLAmGeqJXZwy1v4ZyUjzu6UwEotxUg2c6zPw2xgJO9FGQf6yByuGh+
 Q+MOlKy4Yyf4LBBeDuTqAhM9ml9H2OPhsowcZkOFVdno5jVghpWssfeC8rXfV7v2WQ3bkU6HEp/
 MA030zLO3xBmZy2XVQYK6Kn3BiT0oSjx8/O4jLm2SN5Q==
X-Received: by 2002:a05:701b:2054:b0:191:444:425 with SMTP id
 a92af1059eb24-1b39fe2dd86mr4994304c88.2.1794201668819; 
 Sun, 08 Nov 2026 21:21:08 -0800 (PST)
X-Received: by 2002:a05:701b:2054:b0:191:444:425 with SMTP id
 a92af1059eb24-1b39fe2dd86mr4994281c88.2.1794201668220; 
 Sun, 08 Nov 2026 21:21:08 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b37561ccabsm9576337c88.12.2026.11.08.21.21.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 21:21:07 -0800 (PST)
Message-ID: <4d14d606-6854-432b-a20a-30ce152e5a7b@oss.qualcomm.com>
Date: Sun, 8 Nov 2026 21:21:06 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/hexagon: share the Hexagon VM guest boot code
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
References: <20261109050327.1475448-1-brian.cain@oss.qualcomm.com>
 <20261109050327.1475448-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261109050327.1475448-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAyMCBTYWx0ZWRfXzhvHh1kAOZlR
 pwdA4wNyam7xINs9+14iIsJi5BsCcWGmo2oqBH9ULr8s46nj7e/9/sxndz1jw1Xup3jgKVKUxQr
 IpZwJBdlNXKEqhTYhWGq/2pyk6DxhWWuEyxd+rtRboqrd/pjhtcggn1pUjfSx0iOwgz1/j9hRUF
 4q97WuWSJj3NFnUVRMjyMZGLYL9QZkibZQwY7c6rwdEuo6avJWDldYxCFEuXtGchTjxsmI5kBaj
 d44BJuz9mDoGNh5m4RZq8z4D09FBw5GYviJFvwln2I/IsxIY+alKyhs0dmnpAwovwZy7XqWhV8t
 ZMY4wIf+fcPi/Y433TdFS2DyIE/5nWiYKgOOiULRtBm/TD+cYnxctCgTdFbNYzRTEcdFOs0+fhn
 pNymmbALMZTC+b7KFY+7lLgjim7/pO/XCi7dQuiQBVSWhYRuMZJAJnVrEEFXqQDF59UQfWZfSt5
 leHuILU/GvwL/zqQ4TQ==
X-Authority-Analysis: v=2.4 cv=WOjqzXsR c=1 sm=1 tr=0 ts=6af15845 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=JRHGlkhZF47EYcZCzlYA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAyMCBTYWx0ZWRfX8KDNTnajFMzj
 uoSUfVGS0wME+JAPUgQsH6cuyEjdxDgTmtY+us4/WhLCw1OSDL//tXj8wAfqB+/i2+rBSd6NTUr
 HtYktjPenSptH9TLofGaETYWglUiMsw=
X-Proofpoint-ORIG-GUID: ixJLrRgCVQGBLa5PrWqlVbAR0AiW5FJ7
X-Proofpoint-GUID: ixJLrRgCVQGBLa5PrWqlVbAR0AiW5FJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090020
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

On 11/8/2026 9:03 PM, Brian Cain wrote:
> The DSP subsystem machines boot a guest kernel through the hypervisor
> firmware.  Move that code, the DT nodes, guest timer, into hex-board so that
> it can be used by virt.
> 
> No functional change, this will be used by a subsequent commit.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hex-board.h |  35 +++++++
>  hw/hexagon/hex-board.c         | 138 +++++++++++++++++++++++++
>  hw/hexagon/qcom_dsp.c          | 178 +++------------------------------
>  3 files changed, 187 insertions(+), 164 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


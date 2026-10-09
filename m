Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5DECA9EBB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFIyH-00024r-PX; Fri, 09 Oct 2026 18:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFIy9-00024B-CL
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:21:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFIy7-00008M-V6
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:21:37 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KhlWW3274896
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 22:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hVlvM9e0AWE2aW4sB6UFDll9vFt+UNUNJrYPS6fdkjY=; b=bsrHhIIsgfnCzYNJ
 mvMCkRDTkbBj3QqF9UXIYl+DjUtpZn4dEalifsU5XqrvPhy1OidjDXC53mROWcEC
 oDmP7E2aL/rPw0k1u+KCc1QUyw1MbCaapEfEMSXuj4XpyaPnCpUsX3+pAXLZk0ng
 js0nX4N2OciAS4Xwn6H9V+AQLdD16FM7VOm+6yD5ahm3Fk03h9zlhYdl6cUhBikt
 Sfi53UX2E6YrfY29nIhRi+lZRF+jKPu1DGL3wnM3zl4SQEWES6W9ainIn1bMlh4q
 j0auvzbehjpwRsjIVZ5gCLRbVelg0oDYhyrUmZJYESTW+SUY5jTKa1f4lxcDFzZy
 7M0wJA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t7gxkb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 22:21:33 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-14373747468so89152c88.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 15:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791584493; x=1792189293; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hVlvM9e0AWE2aW4sB6UFDll9vFt+UNUNJrYPS6fdkjY=;
 b=VWgEIFXm5ObRsakqeW8wh5XhkUdHUOmPVtS8JA3mYJJPIPrggQIg1I5PF+D70t74V3
 gaF3GlY576T7a9Ke07QicXC5aJy2DQanb1ONNlF0J/WneV8gC0eNVgB9VpitmNaDviBT
 u1gigCVsqnUeJa7SiWflxOtIPeca0/hKUUgQova+d4o2SI4E9dw9VSJu5c4li/oHowR0
 PhhhI4ejqisgYOSZXS71EtHTdaK5JAwTEdMGCHeE/cIHp0E/M3S5ZcH8LnhSQ81vbwhb
 PpXWfIUA8FL10N53jJQXBxuciMX9ndOSA1PscdNCZpBxcfHrUjdcJKZ+xzuDg5S5tP+E
 petA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791584493; x=1792189293;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hVlvM9e0AWE2aW4sB6UFDll9vFt+UNUNJrYPS6fdkjY=;
 b=DhIoeSYd0wOvS+OV7UbphMpr9FnyzZT//+uXSyJwEfg10321Juj26Okx9PrkyU2Rfv
 IoWDArO14wBpB7GuYDNrGzPfmeYJDrPFNqs1t4Tp0cBOwigAwuEfPVhbFe6lJb+k2Qm+
 AAg9cFlD7jRYQoKGuvr+g3k14iwWSIEDy58eixh8ae4ZP+dB2M5wnQ8q74DCP/VwAR4L
 Mxbt566wL6salwqj3j+RB4u9J4T6PSLcmD62WzmmzBF/qDILZAC8Wbabb24ibif4KLxo
 9PXkf6PMc05yYchWWyhd7GzM/eAU/xYD+ukDaPO1TAdblILZHVbKjRD73DiUsHyES9wl
 ZC9g==
X-Gm-Message-State: AFq9FYKWJshCNu6DPGBRXhuihW8C/LFdmlCrw6LYBcVfJV1mgz8Od/Uf
 yrR2YC1jN/xGyHNzHQlCCl1whKakdGJG06mLcXZezFLoDoAhPb4Ro6pcL5vBQvSeDqI2bEx5DCc
 iygVf9FFpDJo9mA8hwaTw0B7uJwUseTYK7fTk/LkE7cMAIycJIwccN5wpaA==
X-Gm-Gg: AYBFou2Uwlb9i47j67/R2u5/iEGPP+WHFMdFe0onLSQ4vqYuK0gIbzl1seQPezuMH1j
 mPBxs5QHk7S4vsOwe3zh+b2PiBakQAVGwGuybm5NoBwJL6O9nsATsqEgH8vNZDNZ2H8GTR8Uhbx
 FKZGbGtKk07i6ogmxE7fbXfTMI1Kt77Zt7ktciKoKgVijfeJ9j9cbmCrU2jFDMb0bf02TEKMJ7r
 RWe5ny2RO3Be02oaFMsbcVOw4rSYE+epgR/1OwN0576FhIqJKbgQ8L8lxZcRiPo7J+i7QPX0SCI
 YYU4DM858037TJai3QSLp+uewpLA6votCzvE9nlf3HBskN4GFgcXdwPAL2Vgt9q9qnmyQfGJDA/
 iNghdpX3H/lfVNABl140t0aQQ5aGCwHxPqZHjTzxDdF5yrIrs+KxlFGGgUOC+w+n7/zL0ig==
X-Received: by 2002:a05:701b:2810:b0:14c:d8d9:9502 with SMTP id
 a92af1059eb24-16a5e49fe06mr4608118c88.14.1791584492664; 
 Fri, 09 Oct 2026 15:21:32 -0700 (PDT)
X-Received: by 2002:a05:701b:2810:b0:14c:d8d9:9502 with SMTP id
 a92af1059eb24-16a5e49fe06mr4608023c88.14.1791584491347; 
 Fri, 09 Oct 2026 15:21:31 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16996eac537sm8185995c88.1.2026.10.09.15.21.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 15:21:30 -0700 (PDT)
Message-ID: <91a6868b-9f11-4343-a95a-a9832f3dfa74@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 15:21:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] qom: pass TargetInfo to the is_available callback
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Alexander Bulekov <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <3631c54a-5ad7-4037-a21b-37c3c61d712d@oss.qualcomm.com>
 <9ee6fad5-4117-42f2-95da-818d5b4e0aa9@oss.qualcomm.com>
 <CAE2XoE91jjqtF_gW27tQUMiWoJi-pfYQwxWGe75+DFpYmY2iHg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE91jjqtF_gW27tQUMiWoJi-pfYQwxWGe75+DFpYmY2iHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W8atxhWk c=1 sm=1 tr=0 ts=6ac968ed cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=CdOkieOC1uDM26-5aAgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=QYH75iMubAgA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: 7B_SJVAVXHZCgbMmbvwdZx2tSexDFby3
X-Proofpoint-ORIG-GUID: 7B_SJVAVXHZCgbMmbvwdZx2tSexDFby3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA4OSBTYWx0ZWRfX+cl5R/gyq3gz
 Ty7bmiB2RmkXhW1XpVih8L1jUwrRmtQwKN42R5lshRuidTrrA2wb/uODvukexnmQ5Ev9461WJc9
 EQvdFOcTM01gOzXarMcpW3ln1cXIo88=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA4OSBTYWx0ZWRfXwsMFjiec6QxA
 SrWABCQ6RYL4VgmeifpRo9cKIaZ1LVgZ14edjrUl+ib9HJ7XkYwfkggXhBaTU48I+YMMF/Sfk7e
 vaLoXK0jyatoFLq/INPqi+hfpB7eR/Vorfvof8D6UK7dUGUDDWl+3FudHWrOXggi75xsjImg/60
 0/YYj8xgI/C/eDj5brRcY1RLRYbYgtz9l69nNTF7focrSGLQd64zNncmWUa+rQuB4Y+7bPWmHuK
 z2oLWXjQ23Ll1GdD+nzCGw+swg4Mw41K4+UYgcAyVP2aGVI1mDMGoUYQhHzBcjLGXYylQH4d/wv
 MKC4t5EGMm+DbqVeEuwF8gGK1jL/ktYnTB2AlRQYu6cdRSaS3jNY9lGGjIsCy1cGOszvIiB1iRT
 4KflaXxM6hRo8FsDpPP8cp3IATNYUDqzolQMUrxZJeLZ6PrDrJ8tVqGdpmchMEFG8EkA9WZDjqk
 KEw2fFIn0BAr7dbKbOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090089
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/9/2026 3:08 PM, Yonggang Luo wrote:
> On Sat, Oct 10, 2026 at 5:58 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/7/2026 1:46 PM, Pierrick Bouvier wrote:
>>>
>>> I'll pull the first three patches.
>>>
>>
>> Now merged upstream (40ba85501c0b6ac2a7319d3804dab072edf67564)
>>
> 
> Hi Pierrick
> Seems you post to the wrong place.
>

Hi Yonggang,
oops sorry indeed.
I was waiting for previous patches to be merged to send those ones.


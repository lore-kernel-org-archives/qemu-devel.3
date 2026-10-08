Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB24CA600D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 18:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEt9w-0008QS-K6; Thu, 08 Oct 2026 14:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEt9v-0008QH-7F
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:48:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEt9s-0005OF-RL
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:48:01 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698HrLDK3961573
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 18:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K5d8ARuS8qO8+7oMV8D+h1x8sMhjPCL2lkRo8x2oxPs=; b=VDCSwzvkF5xf7/pC
 7t0oeNycxGxm/kaBQSkiq4tM5DNXXdnZRWxIuZfLYlBS7/f6OcE9lFhRyRoTABop
 2lrf4iXLaIZqtgLwL2lNFk0B17n9bztJnqufinDVFweW9qTTSBoatwqUvIyBxjfA
 /kAO3XZfJStIb/MrtvUVcsVWXZb32KaqYu9dKvvJ6dh05ktoMeepWdjdGZJjMIQO
 FJjshjolPCMRUHFIvPgoPIyLhcsSikWxPsjL41sNdT2QEhVgJDd9Rx/aw4cXnMCL
 dJEXkvEj7Vr+CBvM5YdswqBbFuG9/W2nF+Exan5H47crxDuubm6CTwURbh77BwaW
 s4uX8w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fyj071k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 18:47:59 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2df5a65671eso11937855ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 11:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791485279; x=1792090079; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=K5d8ARuS8qO8+7oMV8D+h1x8sMhjPCL2lkRo8x2oxPs=;
 b=VaFPdL4LcNEr13A3I7qDwELCAgYncXV6qUPd0nVayzoZm8EZo1D+hd0o77kle7AleZ
 vR0qvsK6UR78lCq+9dpcg3APUqspGn4s/n1EatYt0bkFZrcVcCb9MmpJ2J5TsOzwL7jT
 A9OsUAHO2dZoLfHmJtytJUErg5n/5pTdJcY5Irg66odZdoVwAtlCXF/nlX5eNuyqYNX6
 1BKTXdgIJdmm2ErypN/fY4WHdPlaWQESDGl9/7hArE/gvfRqlcB9ehFh8CGGG6L/Xbm5
 6hNDf1UXivTL+in7Qgb3xedO/qg8wDS3jyBTYMOikVXDbgh1Y/6chkfh+LAPSc6HQWZu
 1Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791485279; x=1792090079;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K5d8ARuS8qO8+7oMV8D+h1x8sMhjPCL2lkRo8x2oxPs=;
 b=LYnT4Kvw4oU+IvTz3jbqKoKtjUAyeNhTsGuPo5V+iHgsU0nReVmb1BLNd61sReFpif
 Tp0aAbboPG4xHSi/JtG0ZPPQXsghsFFyWLZs5oK5tX87pajS2MYB9Ss6MqW814O4SOQi
 s8rFqGu4L5vR0AV51RZp+5GdN64iz0U4auRhzocwxd1rBk+wYYkS3FHDLeYvJs2Kqni7
 lM8TIcP+K3U/Xc4g/CSxTY7RyN5wgeWRGF1UjqNp74IZ0qO1QCzOxAWTLX2KvSfGCO0V
 yz4TB6NCtGgz3WG9DMggfJIL4ZefJTgrgtLrReizmDCL6RashLn4dSxiJA/vEiVqzp95
 KSEg==
X-Forwarded-Encrypted: i=1;
 AKwUvByaaW6iANIdKGAcUG574/t88tXnzmA5rsSG0zVpVIKLYpV5EDMRhQiO2Py+T71I4mLh5eyQrSKQqXQQ@nongnu.org
X-Gm-Message-State: AFq9FYJinqawBxt5AdvLcbAHHxZMFKEfqCucfk3VsDtiUEr5409p656B
 oLtxwCg9s2DfqWK7Z3ZexYNZkINdd0npTyeBT+icdI7zQDoN+4+XmRg66LQH2MVZ27wpsXuwu2n
 JHznm0WVP67ZKCf6rA58roWw8TngDHwzCdPQi2DiuJ5VbLWYCI6obJbGGeQ==
X-Gm-Gg: AYBFou0Jpa6HQ5nWvfdXp/GPd0ClfXTCX2auvRkASPp/W1fR5NYt6XYLRBkECdYO+5v
 akjid7RWGtgAZpCtZMgSy12NpxKW2Bdd+zl8BsOtEiCoeX4V6KqbL/kLmlM7jJdZmaYEhv5sxmf
 CMKlQkBvMPlghE1MzdWGGAIQqdOFlt3v7KJuXEQOo1QWI84W8xcRLnQFpeADJI4NbVfTOQ+rHrj
 rKE5O13lNvUTYxWOgSZTTX+o7llSE9tfNTwtWhrpPEdtz3WrKgriyPUa9NXncq29e7X3hjTV6vI
 sPXmYnxA9LypQryk+33VJQmecprXqV3OUZzREDpYD4Oq9pO3KfHoYPEn1FmX9y1VlEODsVVDSxr
 TT4YyB5jrU7R1a+iWqvQTzylZEXkCpoKIYghptLIGq2CUYUJ3mnzzNzHoOou/rhyiXUKIsw==
X-Received: by 2002:a17:902:d486:b0:2e6:51c3:89b with SMTP id
 d9443c01a7336-2e7ffd9f406mr21665345ad.4.1791485278958; 
 Thu, 08 Oct 2026 11:47:58 -0700 (PDT)
X-Received: by 2002:a17:902:d486:b0:2e6:51c3:89b with SMTP id
 d9443c01a7336-2e7ffd9f406mr21665245ad.4.1791485278462; 
 Thu, 08 Oct 2026 11:47:58 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e83cb09e88sm709235ad.3.2026.10.08.11.47.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 11:47:58 -0700 (PDT)
Message-ID: <7e29e4b0-c222-4755-901c-2e1593aecb6a@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 11:47:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] gitlab-ci: enable slirp in the Windows cross-build
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20261008184119.142-1-luoyonggang@gmail.com>
 <20261008184119.142-3-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261008184119.142-3-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BfpNQbt2 c=1 sm=1 tr=0 ts=6ac7e55f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=JD23NI8X_dPbIZoBUboA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: noRmg4mGsWWSEXswP4uZ6nhuYs_axaUE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA3NCBTYWx0ZWRfX5KKDGzBln/e7
 QotT+w476nsx/+UuDJXOwB76iteF7JQmGORgiBcWGBuK0ECHQHIYV8Q8a6cuuduLGixbJar293o
 9SuoAJSz5mEyROPf6yGnLOwVaKkOS8uunB1iaVlw39Fs5vpHHvMv+0QGWe0L5V1lxdp9Fhvg18L
 iRNpuaB0CaR7z/+2yNdlfqcodhzdV8bLL+6a9UXQ8pf/0oSDWUNA3CIoXRvGT4cqFEdVFPV+Cf6
 m1wYtkFv1t9uuBGrqsTT4EZTnmESxIMOkw72Y6JICsFC1EyuXOBdmTZbFKfqqRjrLIWG8PA2l6h
 r0wY6Cp9jvd9h1YrKPvLlXYtkgzx9+2bLopzIY311bPLwXpUsywFOe8ymRomFwO4YMVGnNhj4lj
 lzrEZsf835oqlzTX/WSM/1pt4tFMzcCN2hFERfMd4wa0SNZgOxlI4N52MJK54XMj5J6fTQsl9WY
 HL37OGjoTPymly6E1xQ==
X-Proofpoint-GUID: noRmg4mGsWWSEXswP4uZ6nhuYs_axaUE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA3NCBTYWx0ZWRfX7Q+N/3SLuCCz
 PxtCKzCFXOcRiiojhGhDelikK1CIGz5IKcxb6oEZSoQNKMr0LPTChnkj6SQp1F4NZbjALBLipG/
 oZKuM0twvOVjfUis31iLPfORrNGH8G0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080074
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

On 10/8/2026 11:41 AM, Yonggang Luo wrote:
> Require libslirp so check-build compiles the PXE test and catches
> MinGW portability failures instead of omitting the test.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  .gitlab-ci.d/crossbuilds.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


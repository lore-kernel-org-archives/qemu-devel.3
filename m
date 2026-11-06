Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C118606A333
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HXqVvhl4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YpNlh2bC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPO3n-0000nl-Bm; Fri, 06 Nov 2026 12:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPO1w-0000Ux-Re
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:47:15 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPO1v-0006ex-Eh
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:47:12 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6ExtNM101942
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 17:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FFdx4NSjfAGXRMQeWbdmm3lvr+w45Wlq5I7ooJ3Cljg=; b=HXqVvhl4SKcQXM61
 RnWTGo36QqBTRcB5fSNW7akby1GcpivwyJCIdHqdC7FTHli5YvLPAAN6wXvTWem0
 ufX1dsihRjgq3NGedyIVZ3oeBzX5Em4hUWf4LGD6GJXtPM3/Ps/e4zFG8hixNp1B
 KEQiTvhIdkqRd/PWTTtdXolUfRYWUx0gp3qwGIWf3ih5K7cw6FkvbXDoFt0m2L+W
 ORhkohQkJEvMAiLV24ZwrSUXc+AkxCkp+FZh1ufLYvkc9JeIJmJBKol714ttO0x5
 h32Ag52CXUtzQvlLPmCqnijtf94JGu+PFxNV0Q4sLyDUgzNnT0O7lq/FknAAN0gx
 AOqzyA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa40ts-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 17:47:09 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1b25dc2aa8bso1682493c88.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 09:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793987228; x=1794592028; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FFdx4NSjfAGXRMQeWbdmm3lvr+w45Wlq5I7ooJ3Cljg=;
 b=YpNlh2bChPZmS3iq/vvnoyezbypnypzpS+uuJ81cCzc/ssOB53E+YjuT8DLG/wBFYW
 LhAK57LvHtgzThFlylqZBBTDvPuDxWzF/VcyFITDeg1HGbowNUArX+4tudxWfvWsF/ex
 cG70EatyqzbkRaoQiV/1+2nUvv8nMUoPzhRyCve0xbKii55eO8+ovEWnsXuuWd8ZKRzZ
 w3WcANUk/cgfeex8LYqCX2Mi+WcHwhUsFzUdo4yBq70iULIwhpCK01BfV9Quc9cZ2Ypp
 HvzawdFXGtkzA/CP3SxvAOgmChT8GlxCUZUtM1JOj1kAVMJz6qDWIpCScUitUefXUBtM
 X3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793987228; x=1794592028;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FFdx4NSjfAGXRMQeWbdmm3lvr+w45Wlq5I7ooJ3Cljg=;
 b=I/qPGnJL0PNOLmkg/NjIKXdUCJhOnvdTjy+Pa/KPd9tIzijW6vw5jMG9LMeJ4Fr3X7
 xIkrfK8oLPwx+MQ8rD6uq6hOneQht7QL6bqwn9pW3FIOJoQ88LtX/Ge1tafRKl4icQnn
 DRjQ/0qDrsKvZPcvwBkkczVrMLoaDW4nbz7fYizi0odDV1UDJf4DH+U89zhe0Qyy/kQi
 uUBbHH+Hxkl1YsGHBlbLQL6OFBhQvtv1hfXdye7MTO1RACkjMzNTgJ99WyXJTr+hWcq9
 AZ6AP4t3UQFYLJtaH2rAg+z/nEgxq0VyoooQvhSUlAhCyysT4/fIpRQLcyexQn9a/f/b
 jMxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBybTKdLZMMZzsLRvfWa1rOCbXivJQGKygRgd6m1j5zHp958+C0x/SGhvFCJgyLYO322qg/Pgzb9qy0P@nongnu.org
X-Gm-Message-State: APuU4Z9jB60NliBP8U5guV372Abiq/RKD5uwGwsu+GvactzAiSXXTawS
 vjop/Lwj0+zTuHpRPwdp85dmfNQLLKxOuhRKYK5HCx02DaKOR/4Lp189/qIzRtNIsHFR+IzIBVy
 6sAMk/6AtYLak0pc8HltNiq9+sZ+qgkvsu3xW/vzcHBQHllcefA3jX0A7yQ==
X-Gm-Gg: AYBFou08Xl4hXqF8DJBbMfEf0FZc5zXKjEZ/W59TSmsjU3aqpVxMbskGbQAne/3+Wh2
 L8G/gV3RZHH4A27xE+O7MjFxwwa0QGPoZf60kEbyWoFwN75DFJvjvw+luNDWgmcjDC7f8/7wpPp
 iTN1DK6YQxPulYEwB80oSnQs0KdQCp/D3fSaREPasxIDOIWubEu9rfM+jjROqlMCSyyzaswVyz9
 R6oR1MwunmwsBizYC2NY7SK52l2Rl8gvNMs1JIOcUunK6xqvFXOhzDCPiT6gJUZcWqSr3Q08DUD
 7tTYqlTiZBodJgSSF8qowGhom1U0FwxXOgET6U/6KQQGDzRGFhrsFIaMUwN9sAxmR5NA3OCBF40
 Udd0U/voXkJXeRJfq0b5sDf8BP2EOZXfHCI2TywFk0V55Lxj269zD+aj4ujjlVsGqayecFgDA0O
 577cmPlLh4BijHh1CImcNFAs7oxQq6sqvkujK0j2pO7Q==
X-Received: by 2002:a05:7022:3a88:b0:188:ea93:6cf9 with SMTP id
 a92af1059eb24-1b25d34a694mr5034967c88.43.1793987228343; 
 Fri, 06 Nov 2026 09:47:08 -0800 (PST)
X-Received: by 2002:a05:7022:3a88:b0:188:ea93:6cf9 with SMTP id
 a92af1059eb24-1b25d34a694mr5034900c88.43.1793987227677; 
 Fri, 06 Nov 2026 09:47:07 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e4f03f5sm7061093c88.21.2026.11.06.09.47.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 09:47:06 -0800 (PST)
Message-ID: <30cef891-8d93-4db1-bc05-7f6798698283@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 09:47:04 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/misc: move vmlaunchupdate.c to system_ss
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261106171836.2020151-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261106171836.2020151-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfXyDKkUqoJYXG0
 LPWcvA2q5Gx5ysfxpOEpdbAoZXQnZf0P7Y/AWVqEE4yColgxnafGq6qD0JpbNVzREhKXODdpzi7
 Afz1P4ZI/JvoveKDX8VhDCDZwi01ROfSYcwt/uN7OfpvC3GbIax1jfd55Pxl5VWVUEvSPnvElNb
 mtFJg/bbSbvGHQHBuq2Ms3ibJ55dDCgGS5O6qnr9/wmMugnOd29c3+cMlAP8cZBnZ2Z1ap9bKhs
 fto8CXKIHaoAvmGOw/uhb0LdtHdmjPy5IEYPNWiRMbEM+banIA38aE2oE5i3apj0EahSNUWtnXP
 XkCt6wJIERlIACaWv7NZPvX1mCV5WWAaJXtlgF/0RCh+YPnRUyPU7xwYfUp+tGb96NgIBUsMHPV
 ZHj3cFJw7FHAyex5XjfRgy08ZORum2EK8nqQHzHhm2PgSal/ihaFt0Nqy2ANH8TpfTgVtzw5yCA
 1+daaiO4Flkea/41AbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfXyvVUOeJ2J4q5
 3yYAlalo8Oe//dPjWxQ3NpoTWFCZlf8AIjnwdoZ7eZUcTmIGqDGKm8BMb38HNDB21s0JXr8hGsw
 kIvgUlKGPK3A0+LQ+GrQe/fED1VrkX8=
X-Proofpoint-ORIG-GUID: q8SSoABaclKGIpMwis50m379jlj0Rui8
X-Authority-Analysis: v=2.4 cv=GpzXaU1C c=1 sm=1 tr=0 ts=6aee129d cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=cBWFVViQkyuC9rbXWlkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: q8SSoABaclKGIpMwis50m379jlj0Rui8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060070
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

On 11/6/2026 9:18 AM, Daniel P. Berrangé wrote:
> If building with IGVM enabled and both arm-softmmu and
> aarch64-softmmu, test-multi-target breaks because the
> vm-launch-update QOM class is linked in twice and thus
> registered twice.
> 
> Daniel P. Berrangé (4):
>   hw/misc: move vmlaunchupdate.c from specific_ss to system_ss
>   tests/lcitool: add mips32r6el toolchain to refresh script
>   tests/docker: add igvm to Fedora container images
>   MAINTAINERS: fix typo in test-multi-target.c filename
> 
>  MAINTAINERS                                         | 2 +-
>  hw/misc/meson.build                                 | 2 +-
>  tests/docker/dockerfiles/fedora-rust-nightly.docker | 1 +
>  tests/docker/dockerfiles/fedora.docker              | 1 +
>  tests/lcitool/projects/qemu.yml                     | 1 +
>  tests/lcitool/refresh                               | 2 ++
>  6 files changed, 7 insertions(+), 2 deletions(-)
> 

Good catch, thanks.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Sending it for 11.2 as a multi-target fix, with the additional whpx fix.

Regards,
Pierrick


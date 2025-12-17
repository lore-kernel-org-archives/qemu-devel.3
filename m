Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B85D65C56
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVsmV-0002n3-UA; Wed, 17 Dec 2025 09:45:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1vVsmM-0002kH-RI
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:45:30 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1vVsmK-0000zQ-01
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:45:25 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BHCKqfm2673978
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 14:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TT9ooS8BgkF/ClbRDCt0T+F0Mmf3uwo0Mk9LB1Biwa4=; b=Phy53W1G20yN9y0M
 5sMuEwBLgekK2AgImdiabkT8Ilz2YG9WSWcnshSoSGW7g7G/2COCo4sTCRE0bDeg
 OHn5cOLudjsG2nP8T9drMW35WXqNUl3nqGiAU81qdO0eWcH6TSwOrlJi8QB+iJkG
 lS9AuD/K3GRptiu1xOVBmKZ8ImThCXgvtgTSzlOKiYkuBcAz/oqTzOOh5vGm4Ei+
 mA/UXZ1HWiLIQispKzgJ6IDwG/1ETK/s8uqK72EbY6bTXtRTOUsO7ZA+Pt+U1JAi
 qqpFVCPkdPkVjKpQLgJxa4o8L4ByFRmYqQo7F+Rw4qTG2wfbD8xjPfR+dUuG13Dx
 cE7Kxg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3myj202e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 14:45:18 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-11ddcc9f85eso1107114c88.0
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 06:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1765982718; x=1766587518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TT9ooS8BgkF/ClbRDCt0T+F0Mmf3uwo0Mk9LB1Biwa4=;
 b=ZFWnknHbCGSANDvQIL9YSsg6VfdxpWGKxG6uDnljgdSgo04kkrZRnwKzUgJDIIvKsR
 02g+yNuRI5mWImyMmhVNup5VLmBIbc2FAxvCTVohxXOXbnbaLAs19mz8FIFon2ch+U6A
 nw+H5iwk/9FLkW0EQszdR+MK97nJLouP2gIUI/BO/PMXBpdPnEijE7rjKA2VEkT5Ulzg
 emjdvpYg4xkc2l5ps+wSMQnQUqG/b/iouFpbKrAb+yINvLtkSaVOqIrYJDhzWyUAPYRb
 4lPhNhe1RApT5+7F585EeVZQ+elk+1x0BOg+KvKxYhRDmFAbKAk7WPE5vkhRaEYxeRJp
 JHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765982718; x=1766587518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TT9ooS8BgkF/ClbRDCt0T+F0Mmf3uwo0Mk9LB1Biwa4=;
 b=OGYceYuMKkmbgFXeOT9lUa7lsM5uJ4l8vz4S72BBZm5Dyg560fb+xEWtNbHslbUa63
 SEYpXjFr0T3Y7sfkfRd/MZSf6SeBpEAPu+1ilml4457ng3wnALpUhIcanbSV7VEl3HO/
 9Ui9hxYWg8g9oZArgnzA066iXrg1+nqRw3KYMRlTacPL4xya2RwdWCOso/dcNmlW7Sj2
 wkTQF4Fxccq9LzwnTcifQOwr1P0avAIzv7S0ZKAnOEEFHZhcc0r1dVlppLIzpIo60gCk
 fta/x2JU3C9RzzPh+DmlVjZjygYLvJhK4VTrhE/1bqVvHXOseHFZOEbBJpxMQyq/OUeV
 zL2g==
X-Gm-Message-State: AOJu0Yz75op6VjJd9CwbdWQALOQyFsiPoJfs3motmzS/xACH5MWx6xa8
 X6v/2p5pfhcgYqEtAiFXSpEB+Jyt3ocab+K9RsgnAfxNwjLfju7Fvo6TV5sYqpzLvXAgi36QDaJ
 xLqfklxaWJfko51seGC0Da5kHm+Ujq5FhZWR+0ONyOGpwSBCRyi0BrBF+cQ==
X-Gm-Gg: AY/fxX4Tlo9oJXnBIAUA9OijYq0zH6OJBJLQsepDBPK3H6Bakmo0fF4PZkDJ9X5G1a1
 g9dBu26IZ/QTYtwX6DfxjuA/4nqiNkyZCQHYdr0D3xum3gj3zbtilaV1K6CB4MAD06lfIfmEEFj
 TJNNXysR07pTt97yBdruSuTKpLp5GkE/d4wqlO6V/D9VM1jVsFiUkU7ODqCIijXkS5iRUWSToP8
 lWC3XG/OyNdyYQUrScNZieWTR83rbAgoh32ySW28hgp/phJcRehMTtq/3xcyqq9fz3HKrViVKz7
 huAzSv8lX4mx4kqfTp/F16erqcWEOhN09PURpAYOB2+93edAHdfjohLrAuMa49fiHzvAK0tgZ1g
 G8+JFP38lwPeiwC/iatji2ihz9J1GdH0GLegNlDWTcEzwUE5NlrTNgp3l2ZBhKhdhmPdPCpD2
X-Received: by 2002:a05:7022:f517:b0:11b:ca88:c4f1 with SMTP id
 a92af1059eb24-11f34d8b176mr8718427c88.20.1765982717728; 
 Wed, 17 Dec 2025 06:45:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYr8OWtI7bctynh2Y4PFoz/Vr+AygyNSj9aLZPoEiYY6AMlMrZqIqVFTcxVrVb6TNrbfi2pQ==
X-Received: by 2002:a05:7022:f517:b0:11b:ca88:c4f1 with SMTP id
 a92af1059eb24-11f34d8b176mr8718405c88.20.1765982717161; 
 Wed, 17 Dec 2025 06:45:17 -0800 (PST)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11f2e1bb28dsm63221697c88.2.2025.12.17.06.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 06:45:16 -0800 (PST)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: philmd@linaro.org
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 quic_mathbern@quicinc.com, ltaylorsimpson@gmail.com
Subject: Re: [PATCH] target/hexagon: Include missing 'cpu.h' header in
 'internal.h'
Date: Wed, 17 Dec 2025 06:45:14 -0800
Message-Id: <20251217144514.225895-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20251217144211.95032-1-philmd@linaro.org>
References: <20251217144211.95032-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDExMiBTYWx0ZWRfX4Z/sI//15V6g
 LhZpvnVDCfcIoxR6go0Kp8I5nTybCyYlGNfwXB1KjN2jfahQ9eOYiJ/r1OqsvrJUzK3oJ4hXJYG
 9+bSXYg2uwvLQ65ADH+GzGkdEygVu5h5sNJlndVXktATQFuta3hH/AGNwTDgqrgnEOJETwJ2pqJ
 VE85q3q9TuRhqdq3Y0bEgSyJ1gq4GzrUHZK2wlF9JWluSu9nFSRSYGIU0hBncPTuHN8WUetWOuU
 oXWHwFacWEUNWZ3w/kRWwnL+6EJb2zrUukV3nsgmFw4XCYh42M8JKDaOHw99SZnZ9u2XkP7z0s2
 FKhTCtLBgYC1eBzc9k6oRwNiFjjCjfb2zsto3rJbWaz62Rb7bkKXqCH73qnJyGS00dPmhNE48dX
 ZuqqT99SFWomnSGslGcbw2RNsTU1gw==
X-Proofpoint-ORIG-GUID: iyCAjTGyGS39J3A_t-5TKL-FwiUgAxct
X-Authority-Analysis: v=2.4 cv=CtOys34D c=1 sm=1 tr=0 ts=6942c1fe cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=v9uwyzqnjOKTQJhYYZMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: iyCAjTGyGS39J3A_t-5TKL-FwiUgAxct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512170112
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 17 Dec 2025 15:42:11 +0100 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org> wrote:
>
> Both CPUHexagonState and TOTAL_PER_THREAD_REGS are defined
> in "cpu.h" which is luckily indirectly included. However when
> refactoring unrelated files we get:
> 
>   In file included from target/hexagon/helper.h:18,
>                    from include/exec/helper-proto.h.inc:56,
>                    from include/exec/helper-proto.h:13,
>                    from target/hexagon/op_helper.c:22:
>   target/hexagon/internal.h: At top level:
>   target/hexagon/internal.h:29:25: error: unknown type name ‘CPUHexagonState’; did you mean ‘CPUPluginState’?
>      29 | void hexagon_debug_vreg(CPUHexagonState *env, int regnum);
>         |                         ^~~~~~~~~~~~~~~
>         |                         CPUPluginState
>   target/hexagon/internal.h:30:25: error: unknown type name ‘CPUHexagonState’; did you mean ‘CPUPluginState’?
>      30 | void hexagon_debug_qreg(CPUHexagonState *env, int regnum);
>         |                         ^~~~~~~~~~~~~~~
>         |                         CPUPluginState
>   target/hexagon/internal.h:31:20: error: unknown type name ‘CPUHexagonState’; did you mean ‘CPUPluginState’?
>      31 | void hexagon_debug(CPUHexagonState *env);
>         |                    ^~~~~~~~~~~~~~~
>         |                    CPUPluginState
>   target/hexagon/internal.h:33:44: error: ‘TOTAL_PER_THREAD_REGS’ undeclared here (not in a function)
>      33 | extern const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS];
>         |                                            ^~~~~~~~~~~~~~~~~~~~~
> 
> Fix that by including the missing header.
> 
> We don't need the "qemu/log.h" since commit 0cb73cb5a02 ("target/hexagon:
> Remove HEX_DEBUG/HEX_DEBUG_LOG"): remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Acked-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>


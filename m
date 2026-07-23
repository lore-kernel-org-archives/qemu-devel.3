Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C21C531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 17:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmxGc-0002go-4D; Thu, 23 Jul 2026 13:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wmxGM-0002fU-R0
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 13:31:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wmxGL-00044f-1b
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 13:31:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NCw5r73605768
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+mJLxqnU60n
 XC3zPtt1iXvoH8TUk1TpGoUMhDESJ8R0=; b=DQGphXWWSbK2fZf3fQmjWx/IIPx
 QzXZtSgaEodmV2dOU7ccthG+VLwvC6X80MeWTDiVqXFe0e2jzS6eDlm6hKAz9WsJ
 OeIvTgOSi1wCjGvpN2PdBCn+fwUERlJgzeE+voBSLYBzCo5exocVPLny/PhZxGD4
 Ma1iaRo1RlV/k5dmE5/a1XZ8hlxMpJvVgja+JNnM+zE919geoKC5P8ujJLpcmXJJ
 +n77fdeTwZ3hjasIKjE3ZFa4foj4D4XV7HXnfao0zLWhumOEXAhH7aGVMOoJ0Fbf
 rLaLnFoCn1G7IkPuvPAseJkkpR21L9UACXvQgYsIrw7zkWW15Vx7ofA2TYw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkeuqaj56-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:31:07 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e2f61c09dso1436513a91.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784827867; x=1785432667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+mJLxqnU60nXC3zPtt1iXvoH8TUk1TpGoUMhDESJ8R0=;
 b=KsjWA0drlz2hcXlecZQH4MQmFTWIFOMhCkpAbk8cEcDBHwda7oCmi3kb7+xhuitIqc
 /jHRel7hgO2SHjGGewhqy7tYXNH1N52lz4tOdw5HcQ12sTPkON2Mh/uxhJxaJtoD5ecf
 QraE1FfF2Gig+4BJ6k/mfW3fK9quObSGEf1KJgK6EEeuInvwgeKjDZPK7OXb0Z8gl2LR
 WYNa7QDVu4aHXIGQOOUJkToZ3leG1Xy/uridQJ6bYwmpgc/Q5zASaAOnY/JlGMY1XMkW
 ZHIJ6q0rh7Z2BKXBfn8YkY+Grww/At3by4aYvMV3+7XuKUL8FHXR/0pkMahZiJ6Vd0+c
 YD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784827867; x=1785432667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+mJLxqnU60nXC3zPtt1iXvoH8TUk1TpGoUMhDESJ8R0=;
 b=neigKvjtO4Ni5jqwRAutYhMLGaola3x3nuUba1k+9DcxkE/Z9g9izf5HDqcW2PWsj2
 40jxhM79y/avmW1RwbeN5WTuIFR6JDFZiNYzrc05xfFSiCtvMSZOiXEH6hJ2mvqPtzOu
 NQS6gan2Hul1PJxRsYsJvBFLqs33mO6Yhkm2LnXn0GpFC8MKfkM8lokrpcene7pepC4N
 pQwTJlyEomNVBb4dU+ZSyWWJk2WbfjZj8YgSWmdfqUIbyzzPRH5B6NQuMdZVpuFr9r5L
 idaVOMDaWoBIceuH0bKjJRw3BdZ6z8AoL3HYok+EM5ZmpRa2xyUMHWlji1U7fGM8I+0c
 Fsyw==
X-Gm-Message-State: AOJu0YxtpFPTNYwWI7A5YbPnOtTH6XLmrqxFtaCDfE2v2lEN66lXoi1a
 LvE1YpcUf9x+LQARxtBpdRLrC0GLGmd0sdPyiVbUGL+JkYrzm44Dm0+jFpgkQNbdVtkuQvOmKlh
 BmhEsHzwdwS7IEeZ/TU3RBAsLU0Xfl+X3fORjaCAO4/uN4J2lmC/w/tJOow==
X-Gm-Gg: AR+sD103DHw1UhhzHEoafWLCL0K1Uz4hlKYIvDyBejWKmUCTa8i9zH/TMcEBc3JHePw
 rdsXAyvwxDHk+imqtJOKvMw0sBrpT86WgGqwC4QP1AjKwDhdTce3Pvpr0wFBeyFX3ik5ViegzQQ
 6mlUe3yBgK0gRFRBncLB7ZGjOoYuWDZstmzH8jCUsetZnewcKFF0w6XYRDRKUf1XqHYst/2gr2t
 y1TJGK0EYb7WM304rV/I8KOOuhjxRy3/PGB9NxUbq7Q5TuMvE4Efx/xzWAoQxg++K+zAKLZld9T
 hIhmN1N70yaM2SqvLUWbirWTRtSk4nW3E4ZF7GTSrrGY9Fhlvol8ZzpqYQEboL+/dcFkGwGzu3i
 WTBIVEdFwA42AEr9yV4nllKX/Xv/Pzscyw0AYRW7TEqsCZ6u8mpdhzD1/orzgRiE=
X-Received: by 2002:a17:90a:ec88:b0:387:e0cb:7f3 with SMTP id
 98e67ed59e1d1-38ec6883fa2mr3993167a91.39.1784827866818; 
 Thu, 23 Jul 2026 10:31:06 -0700 (PDT)
X-Received: by 2002:a17:90a:ec88:b0:387:e0cb:7f3 with SMTP id
 98e67ed59e1d1-38ec6883fa2mr3993124a91.39.1784827866350; 
 Thu, 23 Jul 2026 10:31:06 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130158c0sm18182070c88.6.2026.07.23.10.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 10:31:05 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, pbonzini@redhat.com,
 lvivier@redhat.com, farosas@suse.de,
 matheus.bernardino@oss.qualcomm.com, damien.hedde@greensocs.com,
 quic_trohmel@quicinc.com, sidneym@quicinc.com,
 tmarcero@qti.qualcomm.com, mkamel@qti.qualcomm.com
Subject: Re: [PATCH 1/3] hw/timer: Add QCT QTimer device model
Date: Thu, 23 Jul 2026 10:31:03 -0700
Message-Id: <20260723173104.2338565-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20260718013241.1550124-2-brian.cain@oss.qualcomm.com>
References: <20260718013241.1550124-2-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3MCBTYWx0ZWRfX7JYWd2eD9MX6
 EQXVP+hMkzyPrqi2bLEx0lNOU9fc0VUrrqoTo9yYwzukgCyEwBAmKjb/q4o0+KvIQ3Z3hivGvFA
 sSkCJqrmfvMzssmiZD2Vos0ez8M9aa0=
X-Proofpoint-ORIG-GUID: g5CKgUDlh2_SpCvGdJOVUMbP4NN4Z7-z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3MCBTYWx0ZWRfXyunHV8IpnPOP
 y+rIXJpZITkIoiYzMlR9JEmb8Pq7EeJJi2dsVBBv88Qy3CA6sFHA4/Tx8X01trfdvJkOKgoQ2I3
 sgws2H9NbfUghfPoEWfiNWjDY9tYJZZetrzd6Tg6J6mssd29VJjGo/+leu47jmq3bx4GiDXYJtE
 p+9q6CzDHZZtEEb3yc/m4igwZae/40MxabCz8GnAqcNmTknlHOTXfNzTj0fnuwy7btdjQ412g02
 AExa7QexeFxj5ynIfJWamDZwnc9cMHoKFmCTTn2js3mm/PLsJZaBzNmPKyEjOWypi+Nb8+K1198
 8ptncOZ/T8ni8+2Zas1kEoqzQ3TrYH+QtCIFcByGl2w/Z8AObw/5n7bUTJD5t3S3wOOsUpt0xV+
 BJkzEYaIeJ3sgHdiznzM5CkixBVhkpMjrCMy3dWo/sho/Rrn0F0rlQWIVjId66cl3Wobnl/6Hv/
 urONBoWNfWpPOAe/YQg==
X-Authority-Analysis: v=2.4 cv=cPDQdFeN c=1 sm=1 tr=0 ts=6a624fdb cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=ieD7xY-6E7G_UUAELuIA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: g5CKgUDlh2_SpCvGdJOVUMbP4NN4Z7-z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230170
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 17 Jul 2026 18:32:39 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> diff --git a/hw/timer/qct-qtimer.c b/hw/timer/qct-qtimer.c
> new file mode 100644
> index 00000000000..fd56a7118b1
> --- /dev/null
> +++ b/hw/timer/qct-qtimer.c
> @@ -0,0 +1,613 @@
> [...]
> +
> +static const Property qct_qtimer_properties[] = {
> +    DEFINE_PROP_UINT32("freq", QCTQtimerState, freq, QTIMER_DEFAULT_FREQ_HZ),

This property sets QCTQtimerState.freq, but it never reaches
QCTHextimerState.freq, right? So even though the user can set and read this
prop value, the value used in the actual calculations doesn't use this?

> +    DEFINE_PROP_UINT32("freq-scale", QCTQtimerState, freq_scale, 1),
> +    DEFINE_PROP_UINT32("nr_frames", QCTQtimerState, nr_frames, 2),
> +    DEFINE_PROP_UINT32("nr_views", QCTQtimerState, nr_views, 1),
> +    DEFINE_PROP_UINT32("frame_stride", QCTQtimerState, frame_stride, 0x1000),
> +    DEFINE_PROP_UINT32("cnttid_0", QCTQtimerState, cnttid_0, 0x11),
> +    DEFINE_PROP_UINT32("cnttid_1", QCTQtimerState, cnttid_1, 0x0),
> +};
> +
 


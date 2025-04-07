Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950B2C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 19:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1sHk-0007mI-5h; Mon, 07 Apr 2025 15:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1u1sHg-0007lh-QH
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 15:37:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1u1sHf-0004QK-7p
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 15:37:28 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537I2WMN022325
 for <qemu-devel@nongnu.org>; Mon, 7 Apr 2025 19:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NTBx8tRI9RK
 +vLOCoxQOYWF0dQwuiP0i9JikaJ5Yasw=; b=Mh6mxSPpXRHhZs9mvj7AkzczPIg
 ZzLAXuoiC/pSvUk4oSp6BTetN48nulPvcJgwQRY7Uf2mj7ThnbVOcfGc3y+3Lg1E
 woPOS6VobDjQU3cIjDit8Y8DmLiygHBmTfilkFBwGTLfKF7yfKWwhBDv1RnSv1Fb
 VS4rUNmC6i0YVUPgFQB3Gsfwr94rM21rhRyu8q6Jo1GwbnWFZG8f2nKk4v47K6WM
 BweMOzn6G3zDXv8nWN0J/WZZfeF5qkuDyS/ctLmN4U41DKsGUhRoomIT/kn/yqgl
 CEbKhzEpHHu2lYx4L9n0GbWQ+wuwoXKsrXi3fn40XmNzFE196iCkzSXrIBQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrdbr8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 19:37:23 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-af5156fbe79so5291267a12.1
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 12:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744054642; x=1744659442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NTBx8tRI9RK+vLOCoxQOYWF0dQwuiP0i9JikaJ5Yasw=;
 b=E++5IJQWgIrVD2vN0eeGsedot6+By43/zfhdARaRwhdVBu6eLPnAilwGtxHI0zqXJs
 xM+lGkhFbF8s1vv/xKc71FN/6m+TxOVonHqUxNu4Fpz0chorF9+TzJtdSC80geB6Zy0i
 3ZleaAa61t5Cjvu+jakGOv8PG/1hA/qiCj1LrkrByLDXyY0GE12Qr15nJt7nAe1ihmxD
 VUu/HZKliQ8zNTS9i22Rutf2vfhwWzjVnVRHkJLuaYmTPbKP9ODl+N/w4JNf+en0pDfc
 RWubXMdydeha6IoB/hKLAIz8alvwPm9CIMa1lOoSLzG03neY4OSRo5RwuvilMYAOcj8w
 p/OQ==
X-Gm-Message-State: AOJu0Yy6/lCdMXYdczSNqbP0819J04cACo2kOByNcd1FvtayURORua3/
 532IjQK9XYCDkjxKkg5xJ8mj+QQMaraRclfF9mDl+jBX37/7uvP81NG2Gh6528+oNagYPNXLzFl
 XOUpPVBaTiMBUHKRHRIOEytVpta2yWq6I/LAfpkQlZKRBnSBSCnsOjA==
X-Gm-Gg: ASbGncvKWD5r/NJPayds4tH5QDThFJpYnJj0L3wcpCxT9QMbeNro5MbdyureYJUtBxO
 x84XxVt67IB1d6JohslqIrVQ+gfla3m5afduFFpPKU3lj/ZZ9x9jkMM/nHUZU3g5FUtpJX+6Fdn
 F/wSHN9Zscc1eedQzDhhADCM5C9MVQGqWbFLrGH4q50kybMk5o3dg5mrTORlLLl2xUKRDoJIXut
 9izo3ZA/GA0saRWs9CQfevMnTbn+JWRhmUEXMLMtuXnFbzaqj2l85Y2a2KvbUoOOVl/rbCS9qQa
 xGNU8Q4tkEN3KfeVib+GwlOjFpD5GnEjqzayFP2cSeb7f/DLQmuBwQs/kz+rvncTrK5WDgmO9XT
 aHy0=
X-Received: by 2002:a05:6a21:4603:b0:1f5:5b2a:f629 with SMTP id
 adf61e73a8af0-20104734ccdmr22434567637.30.1744054641935; 
 Mon, 07 Apr 2025 12:37:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHenIKprimiD9FUd1ZMgJyWDXCh2p1v/1IeUyTwBtWBeK6q9k7JZdKS/m1FDSeak2hs4f8vw==
X-Received: by 2002:a05:6a21:4603:b0:1f5:5b2a:f629 with SMTP id
 adf61e73a8af0-20104734ccdmr22434536637.30.1744054641559; 
 Mon, 07 Apr 2025 12:37:21 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97d17f8sm9210727b3a.10.2025.04.07.12.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 12:37:21 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org,
 matheus.bernardino@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com
Subject: Re: [PATCH v3 0/5] misc hexagon patches
Date: Mon,  7 Apr 2025 12:37:18 -0700
Message-Id: <20250407193718.2371076-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20250407192705.2605614-1-brian.cain@oss.qualcomm.com>
References: <20250407192705.2605614-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: P4NTRqLQJQ5KxeqvNt33hOeGTEZewvKa
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f42973 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=ycicM5sW9l3-bqxbO-wA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: P4NTRqLQJQ5KxeqvNt33hOeGTEZewvKa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_05,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=718 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070137
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon,  7 Apr 2025 12:27:00 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
> 
> Brian Cain (5):
>   target/hexagon: handle .new values
>   target/hexagon: Fix badva reference, delete CAUSE
>   target/hexagon: Add missing A_CALL attr, hintjumpr to multi_cof
>   target/hexagon: s/pkt_has_store/pkt_has_scalar_store
>   target/hexagon: Remove unreachable

All patches,

Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>


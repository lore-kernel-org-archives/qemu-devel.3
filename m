Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7DAC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPgQ-00011i-3t; Tue, 18 Aug 2026 15:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPgO-000106-3i
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:41:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPgM-0002ZA-Cr
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:41:11 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJZauB1816671
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3WbX277rmFKvb8T4Nxlfrh2e/rOu32oCOpXqEokuRKc=; b=jNDLBLo5V9Za+SKH
 QNgwPTcmzXQiVHLJ77cQfIUwLYnOv1lWCFbrDCC42lTqv5tXsi86ZkhWAftG20ED
 oUjJDx4UIW3GQu9zNc7neNg8brP9XTYwS4J+uVGumkMFGCBhmGnSEt4l3biXU2Ex
 Px/JMvcoR1z/SkgtXZXK5fFPdCwxh+2F9H6+mB8YxTT/dCw0FieGzeQP+pu8PRbm
 GXJ89ZONBjjKSzX+eE8B6pg5nWLrmzhy06hQeVdGcp02iEsX+re2sLgiSVXySZke
 28sfTTCJsUVQR42izez7sPL2KOrfrK3k9g8bJVjoOaOcjSyig7Lu3tvTGmvJAMtw
 2rm8sA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4uab0r9f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:41:07 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbee6bb8408so165763a12.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787082065; x=1787686865; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3WbX277rmFKvb8T4Nxlfrh2e/rOu32oCOpXqEokuRKc=;
 b=BDu0FD+lqxgw5tFgMJmnovS75Sr8rboFb2x/97MQehUlfVFxVlZQtLTqeLnIJ+ljhL
 s6Rc4yExfJkMnhHkCGWij9Rde8hNW1apxCeTZUPrPP9UMIAUrQWrMBDfGjWkETSXCdXL
 N+nS1tuwuNmbwrnYBtGGB93eGIrZj1qnPGZnorQ/GI98tStQ9UzJdBGj34B7EzlUZZhv
 NfrygIXfoBNX3+hhYCp+IxUx/qGetPzFJ9lFvSdAhoavNU4SkVrNIuFfqsTdU/W8It3L
 mI7B4d1d/AWoxhRG27JSAt+PdM5rCQkUDKNypthYKKGR54vd3nB0QhyWMPQMTQGVuhyM
 NbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787082065; x=1787686865;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3WbX277rmFKvb8T4Nxlfrh2e/rOu32oCOpXqEokuRKc=;
 b=kjPjBYZ9giqo7m/XAAE+HmhQwN3fag2AMPDjG92pLdutGNg5O0sDtnkBkAzLET+3ma
 0Ot6HkjE5nhls0SUMMTjGuHkXIz17IrWJpL2fXzYMxvddMFkkp26gwqbETcBAKsiiPPO
 vp3TdKTTkRtzfx8ssCh36Y7Ulq98czUAr4NWeYSa9BrdKpQncMDTLKaGPROIsdN+YBFN
 rG/dRBx/IE3BqhdYboOXoyaTzPHAMTu+gLsGJSvFr4TN9Z8dy6us0Kikyr2eFSlIh7ex
 9WWpes8+Yp+2OhE8KXrLltS+NfXBMR4wPP5hjdNGRm0uBCIlWbna/38Ll2qwaQCVyAbR
 GiEQ==
X-Gm-Message-State: AOJu0YzJy9RKiStclp7cC5+fqz1sRFptM3gO8Cj/6258Z/P3PwDmas4/
 gU+xKZ4pgjDRpdLQZ5Dn5edpHN41uEOdpDun0nydQClajr5Xu30wpnEaxaZ4uSH3cgwzv7cCg+k
 PzmY7eAtMFSPvO/dci/th+CVL8fdfgFhEXYCn4ORCWVtCPIHKbv+1b27Njdfxyq1pMA==
X-Gm-Gg: AR+sD11XTTLGYQnzde4zpZ5bJmCw3mFFlv4BA0j4S0u+uQU/udPNquBRwkuG8r3jLnR
 RXiklXYytSE+UHdP8KNSfK9RR8RmRuJ5StN2G6jhxogxJZvmLGWXbzb+uJNAqNFYHmDuQ8Oonl+
 EBysdZtdOkCycgt35lDQjHPk1JlVD+DzjWUjbR5GAg4HWB6teAiJj+filnXgbTlmkZoW1BaEf4a
 aAjdKCkBGjBGd4DRJwHF2KVcPNa2CBxpgFq7Jog0DU4kNhUaZFsLAf0/M8iCPP/2Rehj02xzEoW
 xrPAy4nY1ZDSPhPtpwcO2uTQQ2dy3GMSsfeGCwa443dQY9P17cDzv3XOGx1gsZysm+tt3Zdtedi
 rreivfoWwEJqdL/r3jwqdkKPmkLu+e2N6KkCYqCa+ZSltici7lmC0QjpbjebRyMOK0+MY
X-Received: by 2002:a05:6a20:94c8:b0:3c4:1c9f:d81 with SMTP id
 adf61e73a8af0-3ccff3c3fd3mr205780637.7.1787082065352; 
 Tue, 18 Aug 2026 12:41:05 -0700 (PDT)
X-Received: by 2002:a05:6a20:94c8:b0:3c4:1c9f:d81 with SMTP id
 adf61e73a8af0-3ccff3c3fd3mr205704637.7.1787082064892; 
 Tue, 18 Aug 2026 12:41:04 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1415315900csm19430352c88.11.2026.08.18.12.41.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 12:41:04 -0700 (PDT)
Message-ID: <3950a22d-048f-44b5-a40d-6c4f13d0b393@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 12:41:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 000/103] tests/tcg: run tests with meson
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX24s5cMb896tg
 i6Gg9ryGwKceylfaL4g7mH67VLZ5i1n8QFoasd50P88VeeqrtvVcDlg8HlroK13WnH1Khvkpm9U
 KLuyRhb8nuPHp5FfdTh3hkeFdM/oa5pYZ68eeQz4LgIBvVjWnivODh253FXzCIM085V+cv5wqaz
 BmTzgXK7Iv1kb0Wf6lFBSv3wurNBoaSop58L8eW0+duskItotjFYPmFFmf3CL4zTk+F5cJrrzg+
 RfnjjW/CW10Lk2fbsdTdidG0wbsNaFY4SY/67/W9xJ9GvOyYU0FRtbh3SqMBitdJmtVi3qka3YT
 payZGEPnWLmi2Q2t9Vr1k92fP3C9KIcVf0AP13MoDkiqEcHtjXADVr5gZ+XeyXbSQonW9Mi3wg1
 AzgCCFDgGB/1KTmjmM2t2PHJwL3zHU49DifK2jhaIKOuuv/Y8MtNrLTIKLlk16Zodu6Oweutp+4
 U/CjQqUkwchpMBCiiGw==
X-Authority-Analysis: v=2.4 cv=BvitB4X5 c=1 sm=1 tr=0 ts=6a84b553 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=CufTsKBlnqXwzAhTn0cA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: uoRBjE-tBJQ24nfAP8EeqWOMe6r8LIKf
X-Proofpoint-GUID: uoRBjE-tBJQ24nfAP8EeqWOMe6r8LIKf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX/tD0oF+VXvEy
 J6QvTrLp5HS5v7T2sBBUTH1zyIt7uPny2SfuLF2IXI+7tp6JFjp5wS6OyLOrzoCuL+Hf5WtXBoZ
 WvkJJE5k1ftOejUUUT0ZAxW6OzZmQoU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Sent v7, fixing tests on MacOS + other comments:
https://lore.kernel.org/qemu-devel/20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com/T/#

Regards,
Pierrick


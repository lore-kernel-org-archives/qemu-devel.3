Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F52DC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0vBW-0003cH-SD; Mon, 31 Aug 2026 02:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vBV-0003bq-HB
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:07:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vBT-0005Xs-VI
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:07:57 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52hxi2061164
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 or+a8qRhShzJSGU7HAYsxMssjHXuTGTkuh2s366V5ME=; b=hYQt3a0+EJgQKnV8
 H3JvUnGPAui5ak5cDGLakzG2xx265Lw2V/+BpgPyRDBHl8RDpQR9q/BU/7ly75NE
 wFxHv/ARBztfeQleXWiW7+9rG5GQx4XYFklC43KT82/FS5Y+0qCCLiDxU/RD0dlM
 4TQXccg2/7GZGecFvvJfm1QM5FZoBTWCWbRa76FrNawDZ7OYQasFumooPPGURV8l
 cLSRUMW2ctYxKqjZbFTqh3fMeCGP5RclDBlA14NNExk+b5T6wOoszmYQtk3LYd7D
 erYwYTXks+0sz10WizThfGzl5ULG6TW3UpN7X5MhHFkVBuZ9F43Oyu6+gz1EgRT+
 9bW2JQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbr6dvq9g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:07:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936708f129aso393286485a.0
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 23:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788156473; x=1788761273; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=or+a8qRhShzJSGU7HAYsxMssjHXuTGTkuh2s366V5ME=;
 b=K+3ifNNVAVCw6ZuZa8In0KeOfCUp+kLftFLgmbFwoaDqoYkse6KLEIXfBF2i5mKL1h
 B0Bfi0LEfc1Wgijzva8vVMzCAJsHr0I38blbTARGDXSyWiTKCmhtYUVuBUv7QYefCP1J
 mEyl5+6tvW301axMNdyRtf/H28i5II5wiXvz6yPocbSNd6eGSeHlOBaD0JbqGlyktP9s
 P9fV2iJZYVl40yUReQHr7uPaERuxSYZjoqovlP5tVpR7mEHUEAm+iShXaeqrG1tNy4YI
 M6q/jOL758maxlVyLMvQN3Tt5skxk8qPQNOEskXZ5KSLSLRQoz6gEfngW9PNfeti+tjM
 78ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788156473; x=1788761273;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=or+a8qRhShzJSGU7HAYsxMssjHXuTGTkuh2s366V5ME=;
 b=C2QIxVOj5h4+9vEdn521tNJ9uny1guyEjdqza08wdwkP8zo/rgUg2MH89gXj8ByzKU
 YC3qsQbqGAdho9jiHeHic6zRuk3jrkKNGJfST5dLJ0yxadxaYOV/zYTInSZ6w7wTjqxj
 /YibCRvBcfpflWtVORZMW77kfbAPsaDJWT8siYhql0ptfsB93JUzf8ZdnaN5AsiLzTM4
 9lWAZGBbinIs7Drs0sCxFfSZVD1Js/WZGfTAY+3soJJAs3/j8EKmB90HnAlFuyg40Lsg
 J3xk9BskeAwvyviRtNo2HaGY9VVzbWcbz6TCElxXf0Toos1Fp21+O5XGw20Xw6+bVeXC
 iMrA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcdrPaoVknwsRXJQj9gz93hPLb104AktMNhGNP+wNwH7i/3Gv/K1R70UqTzOK4t5Ow3B0MUzCawy9o@nongnu.org
X-Gm-Message-State: AFuF++m0ZgqC3yNeU2Qpw/7FPRIA/MjXSLRKR58FVesFyqrmzoAJ4zYT
 qgPBkgRDwghsUqz0zjArUwB5z6PXzatF+IDBuj/ilKEinYH4yS5druh2yxAU/Yd2Diphd48npEI
 FcCS1WW9+JSDGA7FZVymFvjFbGpht1GJalsjk27ta9lOV0XSWn6N5nAWpUg==
X-Gm-Gg: AR+sD12OwwnkbUmknKE7tF+vmo9j66zhPaQbSHdiwcP4ROSy9Fzv6+67qe0e9wwVGLB
 Ajz49R5jkklNwSNBWSmKGGft9GjRklI1GzgbZ1dGfWZKf+GycE2b9i0B4go61YKRXZTy/aMfYUd
 kPVRAa8RMISISKxqeV9xvHA8dgFy0bsidUmO6ii3CNCWKEDioojcMqHlyCBkasfPbzC/JzDveRm
 A1EvGIrAQjyCGCzirfrzpqfIVQjCiZysnMBvHySaXYsJ7InsJENDVj7O/m381/F5I4MR7SlrLG8
 esXUvNrrFoN9L3Fue340k2PLOSdckLs/2xAEnqwIJJ8dXa/xiAmvLb4eKWsb70RmC60dfE/4CvE
 4WZ7Tp41we+yceGjIR8rmr53g2d3gNsQKaw==
X-Received: by 2002:a05:620a:4088:b0:932:df51:5172 with SMTP id
 af79cd13be357-93942bed4b8mr76120585a.42.1788156472901; 
 Sun, 30 Aug 2026 23:07:52 -0700 (PDT)
X-Received: by 2002:a05:620a:4088:b0:932:df51:5172 with SMTP id
 af79cd13be357-93942bed4b8mr76117585a.42.1788156472390; 
 Sun, 30 Aug 2026 23:07:52 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4843dcc00a6sm2283259f8f.33.2026.08.30.23.07.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 23:07:51 -0700 (PDT)
Message-ID: <dc702d4c-5344-4139-aae1-f9b10a73e966@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 08:07:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] target/alpha: Use tcg_gen_lea_i64 for S{4,8}ADD{L,Q}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
 <20260828224451.1564072-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828224451.1564072-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1MSBTYWx0ZWRfX7sW7mNYuaybL
 to4/rrDbgcEg6RmP3b5ed3W7jcDR7yNZ6pGda3hYmbXzbx+4R9R+L83v/HwQ/bflyOpt+jERijE
 AWAleZKLTDnk6zcdxhv1xzJfMwzNbQ74ETjdel9MCkV3t+4zdhS+Ac4P+Henpj3OdAv6jS549FX
 bIgR4r4mDIeBuT+TJg1LUWUAaz51PPugBsCsxdrKvbbl9WF84UmU5tB0/R+1Rgt4W7DE4NrqE+g
 1nwzZ31hvhayVgSG44SfEmMgC5766GC2X5KNN5sZumgqZSRbRpXv+VN8toeSP3TBqzYggzFTw2p
 3JzWbLYySqDWpN/JFbNzI5Ql9SSzNg50i9OuNhK0yRnUM+2n4dnFf1DV7hexhD2XPKeu5jolkJv
 FNb1ApllS812D1fbo4gEqTCpVItlioVvdGqMB6vlIcJhCOhd7UDx6XjP3/wpcq9PNIfzkcD5RRD
 W7TChEFxeHF/kiCJ5+g==
X-Proofpoint-GUID: qwwgiVgz94aLWhNsMTQuLLZthNa-kUWi
X-Authority-Analysis: v=2.4 cv=Zakt8MVA c=1 sm=1 tr=0 ts=6a951a39 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=F4whdlzREtsA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1MSBTYWx0ZWRfXzVTjrZy470Le
 GgDOsv74v+n1QGZWtwvMVWoPRPAKXz4m81J37ndpIUtVtg/z79AwRyXPCf7hycqeiPx0zdbiyW7
 n/tVgMTBuHP/fn42A+VCXNXJtf40noQ=
X-Proofpoint-ORIG-GUID: qwwgiVgz94aLWhNsMTQuLLZthNa-kUWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 29/8/26 00:44, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/alpha/translate.c | 20 ++++++--------------
>   1 file changed, 6 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

